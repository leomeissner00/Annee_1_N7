import javax.swing.*;
import java.awt.*;

public class ControleurChat extends JPanel {
	
	public ControleurChat(Chat chat, String lePseudo) {
		super(new FlowLayout());
		
		JLabel pseudo = new JLabel(lePseudo);
		JTextField texte = new JTextField(20);
		JButton bOk = new JButton("OK");
		
		add(pseudo);
		add(texte);
		add(bOk);
		
		bOk.addActionListener(l ->
		chat.ajouter(new MessageTexte(pseudo.getText(), texte.getText())));
	}
	
}
