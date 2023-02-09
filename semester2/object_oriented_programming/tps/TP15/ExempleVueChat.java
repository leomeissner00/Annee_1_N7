
public class ExempleVueChat {
	public static void main(String[] args) {
		Chat chat1 = new Chat();
		System.out.println("-- Premiers messages");
		chat1.ajouter(new MessageTexte("Moi", "Bonjour"));
		chat1.ajouter(new MessageTexte("Toi", "Salut"));
		chat1.ajouter(new MessageTexte("Moi", "Quoi de neuf"));
		
		System.out.println("-- Creation de vue chat texte");
		VueChatTexte vue1 = new VueChatTexte(chat1);
		
		System.out.println("-- Nouveaux messages");
		chat1.ajouter(new MessageTexte("Toi", "Rien"));
		chat1.ajouter(new MessageTexte("Toi", "Et lui?"));
	}
}
