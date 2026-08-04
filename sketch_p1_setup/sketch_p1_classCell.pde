class Cell {

  int i;
  int j;

  boolean visited;

  boolean[] walls;

  Cell(int i, int j) {
    this.i = i;
    this.j = j;

    visited = false;
    
    walls = new boolean [4];
    
    walls[0] = true;
    walls[1] = true;
    walls[2] = true;
    walls[3] = true;
  }

  //draw walls
  void show() {
    
    float x = i * w;
    float y = j * w;
    
    stroke(255);
    
    if (walls[0]) {
      line(x, y, x+w, y);
    }
    if (walls[1]) {
      line(x+w, y, x+w, y+w);
    }
    if (walls[2]) {
      line(x, y+w, x+w, y+w);
     }
    if (walls[3]) {
      line(x, y, x, y+w);
    }
  }

  //highlight current cell
  void highlight() {
    float x = i*w;
    float y = j*w;
    
    fill(144, 238, 144);
    rect(x+1, y+1, w-2, w-2);
  }

  Cell checkNeighbors() {
    
    //Create neighbors array
    ArrayList<Cell> neighbors = new ArrayList<Cell>();
    
    // calculate neighbor indices
    int topIndex = index(i, j - 1);
    int rightIndex = index(i+1, j);
    int bottomIndex = index(i, j+1);
    int leftIndex = index (i-1, j);
    
    // check if cell is within grid
    Cell top = null;
      if (topIndex != -1) {
         top = grid.get(topIndex);
      }
      
    Cell right = null;
      if (rightIndex != -1) {
        right = grid.get(rightIndex);
      }
    
    Cell bottom = null;
      if (bottomIndex != -1) {
        bottom = grid.get(bottomIndex);
      }
      
    Cell left = null;
      if (leftIndex != -1) {
        left = grid.get(leftIndex);
      }
      
    // add unvisited cell to array
   if (top != null && !top.visited) {
     neighbors.add(top);
  }

  if (right != null && !right.visited) {
     neighbors.add(right);
  }

  if (bottom != null && !bottom.visited) {
    neighbors.add(bottom);
   }

  if (left != null && !left.visited) {
    neighbors.add(left);
   }
   
   //check if unvisited neighbor exist
   if (neighbors.size( )> 0) {
     
     //choose random neighbor
     int r = (int) random(neighbors.size());
     return neighbors.get(r);
     }
     return null;
  }
  
  //calculate grid
  int index(int i, int j) {
    if (i < 0 || j < 0 || i >= cols || j >= rows) {
      return -1;
    }
    
   return i+j*cols;
}
    
  }
