package app.piece;

import app.agent.Move;
import app.agent.Player;

public class King extends Piece {

	public King(int player) {
		super(player);
	}

	@Override
	public String toString() {
		return ((this.player == Player.WHITE) ? "R" : "r");
	}

	@Override
	public boolean isMoveLegal(Move mv) {
		// TODO Auto-generated method stub
		return (Math.abs(mv.xI - mv.xF) <= 1) && (Math.abs(mv.yI - mv.yF) <= 1);
	}
}