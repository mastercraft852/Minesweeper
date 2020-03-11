import de.bezier.guido.*;
int NUM_ROWS = 30;
int NUM_COLS = 30; 
int NUM_MINES = 90;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 600);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons=new MSButton[NUM_ROWS][NUM_COLS];
    for(int r=0;r<buttons.length;r++){
        for(int c=0;c<buttons[r].length;c++){
            buttons[r][c]=new MSButton(r,c);
        }
    }
    
    
    
    setMines();
}
public void setMines()
{
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);  
    for(int i = 0; i<NUM_MINES;i++){
        r = (int)(Math.random()*NUM_ROWS);
        c = (int)(Math.random()*NUM_COLS);
        mines.add(buttons[r][c]);
        System.out.println(r+" , "+c);
    }

}

public void draw ()
{
    background( 0 );
    if(isWon() == true){
        displayWinningMessage();
        noLoop();
    }


}
public boolean isWon()
{
    for(int r=0;r<NUM_ROWS;r++){
        for(int c=0; c<NUM_COLS;c++){
            if(!(buttons[r][c].isClicked()^mines.contains(buttons[r][c]))){
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    textAlign(CENTER);
    fill(255,0,0);
    text("you lose! refresh the page to start anew.", width/2, 500);
    noLoop();
    
}


public void displayWinningMessage()
{
    textAlign(CENTER);
    fill(0,255,0);
    text("you win! refresh the page to start anew.", width/2, 500);
}
public boolean isValid(int r, int c)
{
  return r<NUM_ROWS&&c<NUM_COLS&&r>=0&&c>=0;
}
public int countMines(int row, int col)
{
    int count = 0;
    if(isValid(row-1,col-1)&&mines.contains(buttons[row-1][col-1])) count++;
    if(isValid(row-1,col)&&mines.contains(buttons[row-1][col])) count++;
    if(isValid(row-1,col+1)&&mines.contains(buttons[row-1][col+1])) count++;
    if(isValid(row,col-1)&&mines.contains(buttons[row][col-1]))count++;
    if(isValid(row,col+1)&&mines.contains(buttons[row][col+1])) count++;
    if(isValid(row+1,col-1)&&mines.contains(buttons[row+1][col-1])) count++;
    if(isValid(row+1,col)&&mines.contains(buttons[row+1][col])) count++;
    if(isValid(row+1,col+1)&&mines.contains(buttons[row+1][col+1])) count++;
    return count;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
     {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton==RIGHT&&!clicked) flagged = !flagged;
        else if(mines.contains(this)){ 
            displayLosingMessage();
            int i = 10/0;
        }
        else if(countMines(myRow,myCol)!=0) setLabel(countMines(myRow,myCol));
        else{
            if(isValid(myRow, myCol-1)&&!buttons[myRow][myCol-1].isClicked()) buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow, myCol+1)&&!buttons[myRow][myCol+1].isClicked()) buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow-1, myCol)&&!buttons[myRow-1][myCol].isClicked()) buttons[myRow-1][myCol].mousePressed();
            if(isValid(myRow+1, myCol)&&!buttons[myRow+1][myCol].isClicked()) buttons[myRow+1][myCol].mousePressed();
            
        }
        }
    public void draw () 
    {    
        if (flagged)

            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked(){
        return clicked;
    }
}
public void endTheGame(){
    throw new ArithmeticException("dividing a number by 5 is not allowed in this program");
}
