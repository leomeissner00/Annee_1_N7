package tableur;


import java.awt.*;

public class TableurSwing {
    public TableurSwing() {
        new Tableur();
    }

    public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new TableurSwing();
			}
		});
	}
}
