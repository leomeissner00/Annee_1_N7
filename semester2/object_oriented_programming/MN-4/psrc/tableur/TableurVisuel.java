package tableur;


import tableur.composant.*;
import tableur.composant.cellule.CelluleFormule;
//import tableur.composant.cellule.CelluleFormule;
import tableur.exception.FormatFormuleException;
import tableur.math.Formule;
import tableur.math.Lecteur;

import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.plaf.DimensionUIResource;


public class TableurVisuel extends JFrame {
    private String iconPath = "assets/icon.jfif";
    private Color colorSelect = Color.RED;

    private Tableur tableur;
    private Container content;

    private JMenuBar menuBar = new JMenuBar();
    
    JMenu menuFichier = new JMenu("Fichier");
    JMenu menuEditer = new JMenu("Editer");
    JMenu menuOption = new JMenu("Option");
    JMenu menuGraph = new JMenu("Graphique");

    public TableurVisuel( String name,  Tableur tableur) {
        super(name);
        this.tableur = tableur;
        this.content = this.getContentPane();
        setupJFrame();
    }
    
    public void setColorSelect(Color couleur) {
        this.colorSelect = couleur;
    }

    public Color getColorSelect() {
        return this.colorSelect;
    }


    private Cellule getCellule(Position pos) {
        int i = pos.x;
        int j = pos.y;
        return (Cellule) this.content.getComponent(i*(tableur.WIDTH+1)+j);
    }


    public void switchSelect(int dx, int dy) {
        Component focus = this.getFocusOwner();
        Position posi = ((Cellule) focus).getPosition();
        
        if (focus.getClass() == Cellule.class ) {
            Cellule cell = ((Cellule) focus);
            Position realPos = Position.add(cell.getPosition(), tableur.getPosCursor());
            String textEntree = cell.getText();
            if (textEntree.length() > 0 && textEntree.charAt(0) == '=') {
                Formule formule;
                try {
                    formule = Lecteur.convertir(textEntree.substring(1), realPos);
                    tableur.setCellule(realPos, formule);
                } catch (FormatFormuleException e1) {
                    tableur.setCellule(realPos, textEntree );
                }
            } else {
                tableur.setCellule(realPos, textEntree);
            }

            if ( tableur.HEIGHT == posi.x  && (dx == 1)) {
                tableur.cursor.x = tableur.cursor.x + 1;
            } else if ((1 == posi.x) && (dx == -1)) {
                if (tableur.cursor.x != 0) {
                    tableur.cursor.x = tableur.cursor.x - 1;
                } else {
                    tableur.cursor.x = 0;
                }
            } else if ((tableur.WIDTH  == posi.y) && (dy == 1)) {
                tableur.cursor.y = tableur.cursor.y + 1;
            } else if ((1 == posi.y) &&  (dy == -1)) {
                if (tableur.cursor.y >= 1) {
                    tableur.cursor.y = tableur.cursor.y- 1;
                } else {
                    tableur.cursor.y = 0;
                }
            } else {
                Position pos = Position.add(((Cellule) focus).getPosition(), new Position(dx, dy));
                this.getCellule(pos).requestFocus();
            }
            update();
            
        }
        
    }

    public void update() {
        Position posCursor = this.tableur.getPosCursor();
       
        for (int i = 0; i <= tableur.HEIGHT; i++ ) {
            for (int j = 0; j <= tableur.WIDTH; j++ ) {
                if (i == 0 && j== 0) {

                } else if (i == 0) {
                    JLabel label = (JLabel) this.content.getComponent(j);
                    label.setText(Integer.toString(j+posCursor.y));
                } else if (j == 0) {
                    JLabel label = (JLabel) this.content.getComponent(i*(tableur.WIDTH+1));
                    label.setText(Integer.toString(i+posCursor.x));
                } else {
                    Position realPos = new Position(posCursor.x + i, posCursor.y + j);
                    Cellule cellVisuel = (Cellule) this.content.getComponent(i*(tableur.WIDTH+1)+j);
                    cellVisuel.setText(tableur.getCellule(realPos).toString());
                }
            }
        }
    }


    private void setupJFrame() {
        this.setLocation(100, 100);
        
        DimensionUIResource dim = new DimensionUIResource(100, 100);
        try {
            this.setIconImage(ImageIO.read(new File(iconPath)));
        } catch (IOException e2) {
            System.out.print("Icon not found");
        }
        this.setMinimumSize(dim);
        this.setVisible(true);
        this.pack();
        this.setSize(1920, 1080);

        this.setJMenuBar(menuBar);
        menuFichier.add(tableur.itemNouveau);
        menuFichier.add(tableur.itemOuvrir);
        menuFichier.add(tableur.itemEnregistrer);
        menuFichier.add(tableur.itemEnregistrerSous);

        menuEditer.add(tableur.itemAnnuler);
        menuEditer.add(tableur.itemRetablir);
        menuEditer.add(tableur.itemCopier);
        menuEditer.add(tableur.itemCouper);
        menuEditer.add(tableur.itemColler);
        menuEditer.add(tableur.itemRAZ);

        menuOption.add(tableur.itemApparence);
        menuOption.add(tableur.itemFormat);
        menuOption.add(tableur.itemDimension);

        menuGraph.add(tableur.itemNouveauGraph);


        menuBar.add(menuFichier);
        menuBar.add(menuEditer);
        menuBar.add(menuOption);
        menuBar.add(menuGraph);


        this.content.setLayout(new GridLayout(tableur.HEIGHT+1,tableur.WIDTH+1));

        for (int i = 0; i < tableur.HEIGHT+1; i++ ) {
            for (int j = 0; j < tableur.WIDTH+1; j++ ) {
                if (i > 0 && j > 0 ) {
                    Cellule currentCell = tableur.getCellule(new Position(i, j));
                    // currentCell.setText(i + ":" + j);
                    currentCell.setBorder(BorderFactory.createLineBorder(Color.GRAY, 1));
                    this.content.add(currentCell);
                    currentCell.addFocusListener(new FocusListener() {
                        @Override
                        public void focusGained(FocusEvent e) {

                            Cellule cell = ((Cellule) e.getSource());
                            cell.setBorder(BorderFactory.createLineBorder(colorSelect, 2));
                            Position realPos = Position.add(cell.getPosition(), tableur.getPosCursor());
                            Cellule realCell = tableur.getCellule(realPos);
                            if (realCell.getClass() == CelluleFormule.class ) {
                                CelluleFormule formuleCell = (CelluleFormule) realCell;
                                formuleCell.setIsCliked(true);
                                cell.setText(formuleCell.toString());
                            }
                            
                        }
                        @Override
                        public void focusLost(FocusEvent e) {
                            Cellule cell = ((Cellule) e.getSource());
                            cell.setBorder(BorderFactory.createLineBorder(Color.GRAY, 1));
                            Position realPos = Position.add(cell.getPosition(), tableur.getPosCursor());
                            String textEntree = cell.getText();
                            if (textEntree.length() > 0 && textEntree.charAt(0) == '=') {
                                Formule formule;
                                try {
                                    formule = Lecteur.convertir(textEntree.substring(1), cell.getPosition());
                                    tableur.setCellule(realPos, formule);
                                } catch (FormatFormuleException e1) {
                                    tableur.setCellule(realPos, textEntree );
                                }
                            } else {
                                tableur.setCellule(realPos, cell.getText());
                            }
                            update();
                        }
                        
                    });
                    currentCell.addKeyListener(new KeyListener() {
                        @Override
                        public void keyPressed(KeyEvent e) {
                            if (e.getKeyCode() == KeyEvent.VK_LEFT) {
                                switchSelect(0, -1);
                            } else if (e.getKeyCode() == KeyEvent.VK_UP) {
                                switchSelect(-1, 0);
                            } else if (e.getKeyCode() == KeyEvent.VK_RIGHT) {
                                switchSelect(0, 1);
                            } else if (e.getKeyCode() == KeyEvent.VK_DOWN) {
                                switchSelect(1, 0);
                            } 
                            
                        }
                        @Override
                        public void keyReleased(KeyEvent e) {
                        }
                        @Override
                        public void keyTyped(KeyEvent e) {
                        }
                    });
                } else {
                    JLabel currentCell;
                    if (i == 0 && j == 0) {
                        currentCell = new JLabel();
                    } else if ( i == 0) {
                        currentCell = new JLabel(Integer.toString(j));
                        
                    } else {
                        currentCell = new JLabel(Integer.toString(i));;
                    }

                    currentCell.setBorder(BorderFactory.createLineBorder(Color.GRAY, 1));
                    this.content.add(currentCell);
                }
                
            }
        }
    }

    
    
}


  