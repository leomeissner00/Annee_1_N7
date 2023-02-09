
public class VueChatTexte {
	public VueChatTexte(Chat chat) {
		for (Message m : chat) {
			System.out.println(m);
		}
		chat.addObserver((c,m) -> System.out.println(m));
	}
	

}
