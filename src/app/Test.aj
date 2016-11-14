package app;

/**
 * Created by hugopiso on 14/11/2016.
 */
public aspect Test {
    pointcut constructeur()
            : call(app.Board.new());

    before() : constructeur(){
        System.out.println("test premier log ------------------------------");
    }

    after() : constructeur(){
        System.out.println("test premier log ------------------------------");
    }
}
