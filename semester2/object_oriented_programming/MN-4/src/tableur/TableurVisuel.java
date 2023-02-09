package tableur;


import tableur.composant.*;
import tableur.composant.cellule.CelluleFormule;
//import tableur.composant.cellule.CelluleFormule;
import tableur.exception.FormatFormuleException;
import tableur.math.Formule;
import tableur.math.Lecteur;

import java.awt.*;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.plaf.DimensionUIResource;


public class TableurVisuel extends JFrame {
    private String iconPath = "assets/icon.jfif";
    private Color colorSelect = Color.RED;

    private Tableur tab;
    private Container content;

    private JMenuBar menuBar = new JMenuBar();
    
    JMenu menuFichier = new JMenu("Fichier");
    JMenu menuEditer = new JMenu("Editer");
    JMenu menuOption = new JMenu("Option");
    JMenu menuGraph = new JMenu("Graphique");

    public TableurVisuel( String name,  Tableur tab) {
        super(name);
        this.tab = tab;
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
        System.out.print("\ni:" + i +"j:" + j + "\n");
        return (Cellule) this.content.getComponent(i*(tab.WIDTH+1)+j);
    }


    public void switchSelectUp() {
        Component focus = this.getFocusOwner();
        if (focus.getClass() == Cellule.class) {
            Position pos = Position.add(((Cellule) focus).getPosition(), new Position(-1, 0));
            this.getCellule(pos).requestFocus();
        }
    }

    public void update() {
        Position posCursor = this.tab.getPosCursor();
       
        for (int i = 1; i <= tab.HEIGHT; i++ ) {
            for (int j = 1; j <= tab.WIDTH; j++ ) {
                Position realPos = new Position(posCursor.x + i, posCursor.y + j);
                Cellule cellVisuel = (Cellule) this.content.getComponent(i*(tab.WIDTH+1)+j);
                cellVisuel.setText(tab.getCellule(realPos).toString());
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
        menuFichier.add(tab.itemNouveau);
        menuFichier.add(tab.itemOuvrir);
        menuFichier.add(tab.itemEnregistrer);
        menuFichier.add(tab.itemEnregistrerSous);

        menuEditer.add(tab.itemAnnuler);
        menuEditer.add(tab.itemRetablir);
        menuEditer.add(tab.itemCopier);
        menuEditer.add(tab.itemCouper);
        menuEditer.add(tab.itemColler);
        menuEditer.add(tab.itemRAZ);

        menuOption.add(tab.itemApparence);
        menuOption.add(tab.itemFormat);
        menuOption.add(tab.itemDimension);

        menuGraph.add(tab.itemNouveauGraph);


        menuBar.add(menuFichier);
        menuBar.add(menuEditer);
        menuBar.add(menuOption);
        menuBar.add(menuGraph);


        this.content.setLayout(new GridLayout(tab.HEIGHT+1,tab.WIDTH+1));

        for (int i = 0; i < tab.HEIGHT+1; i++ ) {
            for (int j = 0; j < tab.WIDTH+1; j++ ) {
                if (i > 0 && j > 0 ) {
                    Cellule currentCell = tab.getCellule(new Position(i, j));
                    // currentCell.setText(i + ":" + j);
                    currentCell.setBorder(BorderFactory.createLineBorder(Color.GRAY, 1));
                    this.content.add(currentCell);
                    currentCell.addFocusListener(new FocusListener() {
                        @Override
                        public void focusGained(FocusEvent e) {
                            Cellule cell = ((Cellule) e.getSource());
                            cell.setBorder(BorderFactory.createLineBorder(colorSelect, 2));
                            Position realPos = Position.add(cell.getPosition(), tab.getPosCursor());
                            Cellule realCell = tab.getCellule(realPos);
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
                            Position realPos = Position.add(cell.getPosition(), tab.getPosCursor());
                            String textEntree = cell.getText();
                            if (textEntree.length() > 0 && textEntree.charAt(0) == '=') {
                                Formule formule;
                                try {
                                    formule = Lecteur.convertir(textEntree.substring(1), cell.getPosition());
                                    tab.setCellule(realPos, formule);
                                } catch (FormatFormuleException e1) {
                                    tab.setCellule(realPos, textEntree );
                                }
                            } else {
                                tab.setCellule(realPos, cell.getText());
                            }
                            update();
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


  