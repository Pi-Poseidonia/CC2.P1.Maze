int cols, rows;
int w = 40; // width of each cell

ArrayList<Cell> grid = new ArrayList<Cell>();

Cell current;

Player player;

int goalI;
int goalJ;

int startTime;
int elapsedSeconds = 0;
boolean gameWon = false;

int moves = 0;

ArrayList<Cell> stack = new ArrayList<Cell>();

void setup () {
    size(400, 400); //10x10 grid
    cols = width / w;
    rows = height / w;
    
    //Generate the grid
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i< cols; i++) {
        grid.add(new Cell(i,j));
      }
    }
    
    //set goal in the bottom right corner 
    goalI = cols - 1;
    goalJ = rows - 1;
    
    //start DFS at the top-left cell
    current = grid.get(0);
    
    // create player at top-left cell
    player = new Player(0, 0);
    
    //Timekeeping
    startTime = millis();
}

void draw() {
  background(51);
  
  //Draw all cells
  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).show();
  }

  current.visited = true;
  current.highlight();
  
  //Choose a random unvisited neighbor
  Cell next = current.checkNeighbors();
  
  if (next != null) {
    next.visited = true;
    
    //Push the current cell to the stack
    stack.add(current);
    
    //Remove the walls between current and next
    removeWalls(current, next);
    
    //Move forward
    current = next; 
  }
   
    //Backtrack when no unvisited neighbors remain
    else if (stack.size() > 0) {
      current = stack.remove(stack.size()-1);
  }
  
  //highlight goal
  fill(255, 255, 0);;
  rect(goalI * w + 10, goalJ * w + 10, w - 20, w - 20);
  
   //draw player
   player.display();
   
   //track time
  if (!gameWon) {
    elapsedSeconds = (millis() - startTime) / 1000;
  }

   textAlign(RIGHT);
   fill(255);
   textSize(16);
   text("Time: " + elapsedSeconds + " s", 390, 20);
   
   //track moves
   fill(255);
   textSize(16);
   text("Moves: " + moves, 390, 40);
   textAlign(LEFT);
   
   //check win
   if (player.i == goalI && player.j == goalJ) {
    gameWon = true;
   }


  //display win
  if (gameWon) {
  fill(255);
  textSize(32);
  text("You Win!", 120, 200);
  }
}

// Remove the shared wall between current cell and selected neighbor
void removeWalls(Cell current, Cell next) {
  
  //Compare horizontal positions
  int x = current.i - next.i;
  
  //Compare vertical positions
  int y = current.j - next.j;
  
  //Remove wall to right neighbor
  if (x== -1) {
    current.walls[1] = false;
    next.walls[3] = false;
  }
  
  //Remove wall to left neighbor
  else if (x== 1) {
    current.walls[3] = false;
    next.walls[1] = false;
  }
  
  //Remove wall to bottom neighbor
  if (y == -1) {
    current.walls[2] = false;
    next.walls[0] = false;
  }
  
  //Remove wall to top neighbor
  else if (y == 1) {
    current.walls[0] = false;
    next.walls[2] = false;
  }
}
  
//move player with arrow keys
void keyPressed() {

  //block player after win
  if (gameWon) {
    return;
  }
  
  if (keyCode == UP) {
    player.moveUp();
  }

  else if (keyCode == DOWN) {
    player.moveDown();
  }

  else if (keyCode == LEFT) {
    player.moveLeft();
  }

  else if (keyCode == RIGHT) {
    player.moveRight();
  }


}  
