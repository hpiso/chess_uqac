package app;

import app.agent.HumanPlayer;
import app.agent.Move;
import app.agent.Player;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;

/**
 * Created by hugopiso on 14/11/2016.
 */
public aspect Test {
    pointcut check(Move mv, Player player) : execution(boolean app.agent.Player.makeMove(Move))
                && args(mv) && this(player);


    //interception de makeMove pour validation de la conformité du deplacement
    Object around(Move mv, Player player) : check(mv,player){
        Board playGround = player.getPlayGround();

        if(mv == null)
            return false;
        if(!playGround.getGrid()[mv.xI][mv.yI].isOccupied())
            return false;
        if(playGround.getGrid()[mv.xI][mv.yI].getPiece().getPlayer() == player.getColor())
            return false;
        if(!playGround.getGrid()[mv.xI][mv.yI].getPiece().isMoveLegal(mv))
            return false;

        //manger ses propres pieces
        if(playGround.getGrid()[mv.xF][mv.yF].isOccupied() && playGround.getGrid()[mv.xF][mv.yF].getPiece().getPlayer()
                == playGround.getGrid()[mv.xI][mv.yI].getPiece().getPlayer())
            return false;
        //pion +2 at start

        //piece sur le chemin
        boolean tested = false;
        //if bishop
        if(playGround.getGrid()[mv.xI][mv.yI].getPiece().getClass().getName().equalsIgnoreCase("app.piece.Bishop") ||
                playGround.getGrid()[mv.xI][mv.yI].getPiece().getClass().getName().equalsIgnoreCase("app.piece.Queen")){
            //if diagonal
            if(Math.abs(mv.xI - mv.xF) != 0 && Math.abs(mv.yI - mv.yF) != 0){
                tested = true;
            }
            //if not queen ou queen but not diagonal
            if(!playGround.getGrid()[mv.xI][mv.yI].getPiece().getClass().getName().equalsIgnoreCase("app.piece.Queen") ||
                    tested) {
                if (mv.yI < mv.yF && mv.xI < mv.xF) {
                    int i = mv.xI + 1;
                    int y = mv.yI + 1;
                    while (i < mv.xF && y < mv.yF) {
                        if (playGround.getGrid()[i][y].isOccupied())
                            return false;
                        i++;
                        y++;
                    }
                }
                if (mv.yI > mv.yF && mv.xI > mv.xF) {
                    int i = mv.xI - 1;
                    int y = mv.yI - 1;
                    while (i > mv.xF && y > mv.yF) {
                        if (playGround.getGrid()[i][y].isOccupied())
                            return false;
                        i--;
                        y--;
                    }
                }
                if (mv.yI < mv.yF && mv.xI > mv.xF) {
                    int i = mv.xI - 1;
                    int y = mv.yI + 1;
                    while (y < mv.yF && i > mv.xF) {
                        if (playGround.getGrid()[i][y].isOccupied())
                            return false;
                        i--;
                        y++;
                    }
                }
                if (mv.yI > mv.yF && mv.xI < mv.xF) {
                    int i = mv.xI + 1;
                    int y = mv.yI - 1;
                    while (y > mv.yF && i < mv.xF) {
                        if (playGround.getGrid()[i][y].isOccupied())
                            return false;
                        i++;
                        y--;
                    }
                }
            }

        }
        //if other than knight || bishop and queen not tested
        if(!playGround.getGrid()[mv.xI][mv.yI].getPiece().getClass().getName().equalsIgnoreCase("app.piece.Knight") && !tested){
            //if not queen ou queen but not diagonal
            if(!playGround.getGrid()[mv.xI][mv.yI].getPiece().getClass().getName().equalsIgnoreCase("app.piece.Queen") ||
                    !tested) {
                if (mv.xI < mv.xF) {
                    int i = mv.xI + 1;
                    while (i < mv.xF) {
                        if (playGround.getGrid()[i][mv.yI].isOccupied())
                            return false;
                        i++;
                    }
                }
                if (mv.yI < mv.yF) {
                    int i = mv.yI + 1;
                    while (i < mv.yF) {
                        if (playGround.getGrid()[mv.xI][i].isOccupied())
                            return false;
                        i++;
                    }
                }
                if (mv.xI > mv.xF) {
                    int i = mv.xI - 1;
                    while (i > mv.xF) {
                        if (playGround.getGrid()[i][mv.yI].isOccupied())
                            return false;
                        i--;
                    }
                }
                if (mv.yI > mv.yF) {
                    int i = mv.yI - 1;
                    while (i > mv.yF) {
                        if (playGround.getGrid()[mv.xI][i].isOccupied())
                            return false;
                        i--;
                    }
                }
            }
        }

        playGround.movePiece(mv);
        System.out.println("Deplacement valide");
        return true;
    }



}
