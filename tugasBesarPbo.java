import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class tugasBesarPbo {
    public static void main(String[] args) {
      if(args.length > 0){

       String[] files = args;

        Scanner in = new Scanner(System.in);
	      System.out.println("==================================================================================");
        System.out.println("\t \t \t # PROGRAM PENCARI KATA #");
        System.out.println("==================================================================================");
        System.out.println("Masukkan kata yang ingin dicari: ");
        String searchword = in.nextLine();

        for(int i=0; i<files.length; i++){
            String file = files[i];

            try {
                int LineCount = 0;
                String line = "";

                BufferedReader b = new BufferedReader(new FileReader(file));

                while ((line = b.readLine()) != null) {
                       LineCount++;

                       int colFound = line.indexOf(searchword);

                        if (colFound > - 1) {
                                System.out.println("kata "+searchword+ " ditemukan pada baris ke-" +LineCount+ " kolom ke: " +colFound+ " pada file " +file);
                              }
                        }
                        b.close();
                }
            catch (FileNotFoundException e) {
                        System.out.println("Error: " + e.toString());
                }
                catch (IOException e) {
                        System.out.println("salah: " + e.toString());
                }
        };
	    }
	    else{
		     System.out.println("masukan direktori file terlebih dahulu");
	         }
	    }
}
