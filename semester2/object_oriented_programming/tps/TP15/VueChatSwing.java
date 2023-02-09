import javax.swing.*;

public class VueChatSwing extends JTextArea{
	
	public VueChatSwing(final Chat chat, int nbLignes, int nbColonnes) {
		super(nbLignes, nbColonnes);
		this.setEditable(false);

		for(Message m : chat) {
			this.append("" + m + "\n");
		}
		
		chat.addObserver((c, m) -> this.append("" + m + "\n")); 
	}


}
