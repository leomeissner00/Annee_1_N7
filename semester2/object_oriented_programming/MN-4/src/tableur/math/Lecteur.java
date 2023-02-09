package tableur.math;

import java.util.HashMap;

import tableur.composant.Position;
import tableur.exception.FormatFormuleException;
import tableur.math.formule.*;

public class Lecteur {

    final static HashMap<Character, Integer> ORDER_PRIORITY = new HashMap<Character, Integer>() {{
        put('+', 1);
        put('-', 1);
        put('*', 2);
        put('/', 2);
        put('^', 3);
    }};

    final static int MAX_ORDER = 3;
    
    private static String removeSpace(String text) {
        int n = text.length();
        int i = n-1;
        while (i >= 0) {
            if (text.charAt(i) == ' ') {
                text = text.substring(0,i).concat(text.substring(i+1, text.length()));
            }
            i--;
        }
        return text;
    }

    public static Formule convertir(String formule, Position pos) throws FormatFormuleException {
        formule = removeSpace(formule);
        int prof = 0;
        try {
            double value = Double.parseDouble(formule);
            return new FormuleConstante(value);
        } catch (NumberFormatException e) {
            final int n = formule.length();
            
            for (int step = 1; step <= MAX_ORDER; step++) {
                Boolean inBracket = false;
                for (int i = n-1; i >= 0; i--) {
                    
                    char carac = formule.charAt(i);
                    switch (carac) {
                        case ']':
                            inBracket = true;
                            break;
                        case '[':
                            inBracket = false;
                            break;
                        case '(' :
                            prof--;
                            break;
                        case ')':
                            prof++;
                            break;
                        case '+':
                            if (prof == 0 && step == ORDER_PRIORITY.get('+') && !inBracket) {
                                Formule sf1 =  Lecteur.convertir(formule.substring(0, i), pos);
                                Formule sf2 =  Lecteur.convertir(formule.substring(i+1, n), pos);
                                return new FormuleAddition(sf1, sf2);
                            }
                            break;
                        case '-':
                            if (prof == 0 && step == ORDER_PRIORITY.get('-') && !inBracket) {
                                Formule sf1 =  Lecteur.convertir(formule.substring(0, i), pos);
                                Formule sf2 =  Lecteur.convertir(formule.substring(i+1, n), pos);
                                return new FormuleSoustraction(sf1, sf2);
                            }
                            break;
                        case '*':
                            if (prof == 0 && step == ORDER_PRIORITY.get('*') && !inBracket) {
                                Formule sf1 =  Lecteur.convertir(formule.substring(0, i), pos);
                                Formule sf2 =  Lecteur.convertir(formule.substring(i+1, n), pos);
                                return new FormuleMultiplication(sf1, sf2);
                            }
                            break;
                        case '/':
                            if (prof == 0 && step == ORDER_PRIORITY.get('/') && !inBracket) {
                                Formule sf1 =  Lecteur.convertir(formule.substring(0, i), pos);
                                Formule sf2 =  Lecteur.convertir(formule.substring(i+1, n), pos);
                                return new FormuleDivision(sf1, sf2);
                            }
                            break;
                        case '^':
                            if (prof == 0 && step == ORDER_PRIORITY.get('^') && !inBracket) {
                                Formule sf1 =  Lecteur.convertir(formule.substring(0, i), pos);
                                Formule sf2 =  Lecteur.convertir(formule.substring(i+1, n), pos);
                                return new FormulePuissance(sf1, sf2);
                            }
                            break;
                        default:
                            break;
                    }
                    
                }
            }
            if (n >= 2) {
                
                if (formule.charAt(0) == '(' && formule.charAt(n-1) == ')') {
                    Formule sf = Lecteur.convertir(formule.substring(1, n-1), pos);
                    return new FormuleParenthese(sf);
                }
                if (formule.charAt(0) == '[' && formule.charAt(n-1) == ']') {
                    String[] cell = formule.substring(1, n-1).split(":");
                    if (cell.length != 2) {
                        throw new FormatFormuleException("Format cellule invalide");
                    }
                    
                    if (cell[0].length() >= 1) {
                        try {
                            if (cell[0].charAt(0) == '&') {
                                int c1 = Integer.parseInt(cell[0].substring(1,cell[0].length()));
                                int c2 = Integer.parseInt(cell[1]);
                                return new FormuleCelluleRelative(c1,c2, pos);
                            } else {
                                int c1 = Integer.parseInt(cell[0]);
                                int c2 = Integer.parseInt(cell[1]);
                                return new FormuleCellule(c1,c2);
                            }
                        } catch (NumberFormatException e2) {
                            throw new FormatFormuleException("Les indices d'une cellules doivent etre des entier");
                        }
                        
                        
                    }
                    
                }
                if (n >= 14) {
                    if (formule.substring(0, 6).equals("SOMME(") && formule.charAt(n-1) == ')' ) {
                        String[] cells = formule.substring(6,n-1).split(",");
                        if (cells.length != 2) {
                            throw new FormatFormuleException("Format SOMME invalide");
                        }
                        String[] cell1 = cells[0].split(":");
                        String[] cell2 = cells[1].split(":");
                        if (cell1.length != 2 || cell2.length != 2) {
                            throw new FormatFormuleException("Format cellule dans SOMME invalide");
                        }
                        try {
                            Position p1 = new Position(Integer.parseInt(cell1[0]), Integer.parseInt(cell1[1]));
                            Position p2 = new Position(Integer.parseInt(cell2[0]), Integer.parseInt(cell2[1]));
                            return new FormuleSomme(p1, p2);
                        } catch (NumberFormatException e2) {
                            throw new FormatFormuleException("Les indices d'une cellules doivent etre des entiers");
                        }
                    }
                } 
            }
            throw new FormatFormuleException("Format formule error :" + formule);
        }
    }
}
