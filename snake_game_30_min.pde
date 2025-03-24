ArrayList<Integer> snake_x = new ArrayList<Integer>(), snake_y = new ArrayList<Integer>();

int blocks = 20, block_size, food_x, food_y, direction = 1, speed = 10;
int[] dir_x = {-1, 1, 0, 0}, dir_y = {0, 0, -1, 1};

boolean game_running = true;

void setup(){
  surface.setTitle("Snake Game");
  size(600, 600); 
  
  block_size = (int)(width/blocks);
  
  food_x = (int)random(0, (blocks-1)) * block_size;
  food_y = (int)random(0, (blocks-1)) * block_size;
  
  snake_x.add((int)width/2);
  snake_y.add((int)height/2);
  
}

void draw(){
  background(15);
  strokeWeight(1);
  stroke(2); 
  if(game_running){
    
    //draw food
    fill(#FFA148);
    square(food_x, food_y, block_size);
  
    //draw snake
    fill(#14B712);
    for(int i = 0; i < snake_x.size(); i++){
      square(snake_x.get(i), snake_y.get(i), block_size);
    }
  
    //draw score
    textAlign(LEFT);
    textSize(25);
    fill(255);
    text("Score: " + (snake_x.size() - 1), 10, 30);
    
    if(frameCount % speed == 0) updateGame();
  } else{
    fill(200, 10, 10);
    textAlign(CENTER);
    textSize(40);
    text("GAME OVER\nYour Score: " + (snake_x.size() - 1) + "\nPress Enter to Restart...", width/2, height/2-20);
    if(keyCode == ENTER){
      snake_x.clear();
      snake_y.clear();
      snake_x.add((int)width/2);
      snake_y.add((int)height/2);
      speed = 10;
      direction = 0;
      game_running = true;
    }
  }
}

void updateGame(){
  snake_x.add(0, (int)snake_x.get(0) + dir_x[direction] * block_size);
  snake_y.add(0, (int)snake_y.get(0) + dir_y[direction] * block_size);
  
  //Check Collision
  if(snake_x.get(0) < 0 || snake_y.get(0) < 0 || snake_x.get(0) >= width || snake_y.get(0) >= height)
    game_running = false;
  if(snake_x.size()>1)
  for(int i = 1; i < snake_x.size(); i++){
    if(snake_x.get(0) == snake_x.get(i) && snake_y.get(0) == snake_y.get(i))
      game_running = false;
  }
  
  
  //Check if food eaten  
 if(snake_x.get(0) == food_x && snake_y.get(0) == food_y){
   food_x = (int)random(0, (blocks-1)) * block_size;
   food_y = (int)random(0, (blocks-1)) * block_size;
   
   if(snake_x.size() % 4 == 0 && speed > 2) speed -= 1;
 }else{
  snake_x.remove(snake_x.size() - 1);
  snake_y.remove(snake_y.size() - 1);
 }
}

void keyPressed(){
  switch(key){
    case 'a':
      direction = direction == 1 && snake_y.size()>1 ? direction : 0;
      break;
    case 'd':
      direction = direction == 0 && snake_y.size()>1 ? direction : 1;
      break;
    case 'w':
      direction = direction == 3 && snake_y.size()>1 ? direction : 2;
      break;
    case 's':
      direction = direction == 2 && snake_y.size()>1 ? direction : 3;
      break;
    default:
      break;
  }
}
