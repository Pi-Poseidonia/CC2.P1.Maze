class Player {

  int i;
  int j;

  // Player constructor
  Player(int i, int j) {
    this.i = i;
    this.j = j;

  }
  
   // show player position
  void display() {
    float x = i*w;
    float y = j*w;
 
    //draw circle for player
    noStroke();
    fill(255, 0, 0);
    ellipse(x+w/2, y+w/2, w/2, w/2); 
  }

  void moveUp() {
    Cell currentCell = grid.get(i + j * cols);
      if (!currentCell.walls[0]) {
      j--;
      moves++;  
    }
  }

  void moveDown() {
    Cell currentCell = grid.get(i + j * cols);
      if (!currentCell.walls[2]) {
      j++;
      moves++;  
      }
  }

  void moveLeft() {
    Cell currentCell = grid.get(i + j * cols);
      if (!currentCell.walls[3]) {
      i--;
      moves++;        
    }
  }

  void moveRight() {
    Cell currentCell = grid.get(i + j * cols);
      if (!currentCell.walls[1]) {
      i++;
      moves++;        
      }
  }
  
}
