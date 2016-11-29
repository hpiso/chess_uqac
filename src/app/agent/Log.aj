package app.agent;

import java.io.*;

/**
 * Created by hugopiso on 14/11/2016.
 */
public aspect Log {

    pointcut moving():
            call(* Player.makeMove());

    after() returning(Object r) : moving(){

        BufferedWriter bw = null;
        File f = new File("./output.txt");

        if (f.exists()) {
            try {
                bw = new BufferedWriter(new FileWriter(f, true));
                bw.newLine();
                bw.write(thisJoinPoint + " - Coup joué : " + r.toString());
                bw.flush();
            } catch (FileNotFoundException ex) {
                System.out.println(ex.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            try {
                bw = new BufferedWriter(new FileWriter(f));
                bw.write(thisJoinPoint + " - Coup joué : " + r.toString());
                bw.flush();
            } catch (FileNotFoundException ex) {
                System.out.println(ex.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
