private MSButton[][] buttons;
private ArrayList <MSButton> explosives;
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private boolean isLost = false;
private int tileCount = 0;

void setup ()
{
    textAlign(CENTER,CENTER);
    size(500, 500);
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    explosives = new ArrayList <MSButton>();
    for(int j = 0;j<NUM_COLS;j++){
        for(int i = 0; i < NUM_ROWS;i++){
            buttons[i][j]= new MSButton(i,j);
    }
} 
    setexplosives();
}

public void setexplosives(){  
  for (int i = 0; i < 35; i++) {
    final int r1 = (int)(Math.random()*20);
    final int r2 = (int)(Math.random()*20);
    if ((explosives.contains (buttons[r1][r2])) == false) {
      explosives.add(buttons[r1][r2]);
    }
    else {i--;}
}
}

public void draw (){
    background(0);
    if(isWon()==true){
        WinningMessage();
    }
    for (int i = 0; i < NUM_ROWS; i++) {
     for (int j = 0; j < NUM_COLS; j++) {
        buttons[i][j].draw();
      } 
    }
}

public boolean isWon()
{
     int nonExplosiveTiles = NUM_ROWS * NUM_COLS - explosives.size();
     
    if( tileCount == nonExplosiveTiles){
      return true;
}
else{
  return false;}
}

public void LosingMessage()
{     
    for(int i=0;i<explosives.size();i++){
        if(explosives.get(i).isClicked()==false){
            explosives.get(i).mousePressed();
        }
    }
    isLost = true;
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("L");
    buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("S");
    buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("E");
}

public void WinningMessage()
{
    isLost = true;
    
    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("U");
    buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("W");
    buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("I");
    buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("N");
    buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("!");
}

public void mousePressed (){
  int mX = mouseX;
  int mY = mouseY;
  buttons[(int)(mY/25)][(int)(mX/25)].mousePressed();
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;   
    public MSButton (int rr, int cc){
        width = 500/NUM_COLS;
        height = 500/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
    }

public boolean isMarked(){
        return marked;
}

public boolean isClicked(){
        return clicked;
}
    
public void mousePressed (){
      if (isLost == false) {
        if (mouseButton == RIGHT && buttons[r][c].isClicked()) {     
        }
        else if (mouseButton == RIGHT) {
          marked = !marked;
        }
        else if (marked == true) {}
        else if (explosives.contains(this)) {
          clicked = true;
          LosingMessage();
        }
        else if (countbomb(r,c) > 0) {
          label = ""+countbomb(r,c);
          if (!clicked) {tileCount+=1;}
          if (tileCount == 900-explosives.size()) {WinningMessage();}
          clicked = true;
        }
        else {
          if (!clicked) {tileCount+=1;}
          if (tileCount == 900-explosives.size()) {WinningMessage();}
          clicked = true;
          
          if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()) {
          buttons[r-1][c-1].mousePressed();} 
          if(isValid(r-1,c) && !buttons[r-1][c].isClicked()) {
          buttons[r-1][c].mousePressed();}
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()){
          buttons[r-1][c+1].mousePressed();}
          
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked()){
          buttons[r][c-1].mousePressed();}
          if(isValid(r,c+1) && !buttons[r][c+1].isClicked()){
          buttons[r][c+1].mousePressed();}
          
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()){
          buttons[r+1][c-1].mousePressed();}
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked()){
          buttons[r+1][c].mousePressed();}
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()){
          buttons[r+1][c+1].mousePressed();}
        }
      }
    }

public void draw () {    
if (marked){
    fill(0);
}
         else if( !marked && clicked && explosives.contains(this) ) {
             fill((float)Math.random()*255, (float)Math.random()*255, (float)Math.random()*255);
         }
         else if( marked && explosives.contains(this) ) {
             fill(100);
         }
         else if(!marked && clicked && !explosives.contains(this)) {
             fill(200);
         }
        else if(clicked){
            fill(200);
        }
        else {
            fill(100);
        }
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
}

public void setLabel(String newLabel){
        label = newLabel;
}

public boolean isValid(int r, int c){
        if (r <NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0) {
        return true;
      }
        return false;
 }

public int countbomb(int row, int col){
        int bombnum = 0;
        if (isValid(row-1,col) == true && explosives.contains(buttons[row-1][col]))
        {
            bombnum++;
        }
        if (isValid(row+1,col) == true && explosives.contains(buttons[row+1][col]))
        {
            bombnum++;
        }
         if (isValid(row,col-1) == true && explosives.contains(buttons[row][col-1]))
        {
            bombnum++;
        }
         if (isValid(row,col+1) == true && explosives.contains(buttons[row][col+1]))
        {
            bombnum++;
        }
         if (isValid(row-1,col+1) == true && explosives.contains(buttons[row-1][col+1]))
        {
            bombnum++;
        }
         if (isValid(row-1,col-1) == true && explosives.contains(buttons[row-1][col-1]))
        {
            bombnum++;
        }
         if (isValid(row+1,col+1) == true && explosives.contains(buttons[row+1][col+1]))
        {
            bombnum++;
        }
         if (isValid(row+1,col-1) == true && explosives.contains(buttons[row+1][col-1]))
        {
            bombnum++;
        }
        return bombnum;
    }
}
