package app.agent;

import java.io.*;

/**
 * Created by hugopiso on 14/11/2016.
 */
public aspect Test {

    pointcut moving():
            call(* Player.makeMove());

    after() returning(Object r) : moving(){
        System.out.println("Aspect return: "+r.getClass().getName());

        File fout = new File("out.txt");
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(fout);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(fos));


        try {
            bw.write(r.toString());
            bw.newLine();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

}
