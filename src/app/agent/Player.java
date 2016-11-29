package app.agent;


import app.Board;

public abstract class Player {
	public static final int WHITE = 1;
	public static final int BLACK = 0;
	
	protected int Colour;
	protected Board playGround;

	public abstract boolean makeMove(Move mv);
	public abstract Move makeMove();
	
	public int getColor(){
		return this.Colour;
	}
	public void setColor(int arg){
		this.Colour = arg;
	}

	public Board getPlayGround() {
		return playGround;
	}

	public void setPlayGround(Board playGround) {
		this.playGround = playGround;
	}
}
