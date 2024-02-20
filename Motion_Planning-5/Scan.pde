//variabili scanner
boolean s = false;   //variabile scanner
int num_iter = 2500;
float start_alpha = (2*PI)/num_iter;
float alpha = start_alpha;

//TARGET
float id_target = 6;

boolean scan(float x, float y, float len_max, color colore)
{    //x,y coordinate del roomba rispetto a SR0, len_max raggio max laser 

  float xi, yi, xi_0, yi_0;
  float len_x = posxsp[nfigurasp-1]/2;
  float len_y = posysp[nfigurasp-1]/2;
  boolean same_obstacle;
  int detected_obs;



  pushMatrix();
  translate(x, y);     //mi pongo nel SR del robot
  len_x = cos(alpha)*len_max;
  len_y = sin(alpha)*len_max;


  stroke(colore);
  stroke(#6DCEF0);

  fill(255);
  stroke(255);
  circle(len_x, len_y, 5);  //pallino bianco finale
  //figura(60, len_x, len_y, 0); //disegno robot

  //xi,yi sono le coordinate del punto verde sul foglio appunti progetto
  //xi,yi sono espresse rispetto a SR robot

  //x,y inizio laser --- len_x,len_y fine laser
  float[] intersection_obstacles = intersectionObstacles(x, y, len_x, len_y); //possibile intersezione con tavolo
  float[] intersection_wall = intersectionWall(x, y, len_x, len_y); //possibile intersezione con ostacolo


  if (intersection_obstacles[0] == 1) //intersezione con ostacolo
  {
    xi = intersection_obstacles[1];
    yi = intersection_obstacles[2];
    println("intersezione ostacolo");
    

  } else 
  {
    //intersection_wall[0];  dal momento che se non interseca un ostacolo  SICURAMENTE ci sarà un intersezione col bordo
    xi = intersection_wall[1];
    yi = intersection_wall[2];
    println("intersezione tavolo --> misura tavolo x", posxsp[nfigurasp-1], " misure calcolate x ->>>", xi);
    println("misura tavolo y",posysp[nfigurasp-1], " misure calcolate y ->>>", yi);
  }

//coordinate di xi rispetto a SR0
  xi_0 = xi + x;        
  yi_0 = yi + y;

  //detected_obs = is_in_obstacle(xi_0, yi_0);        // ID dell'ostacolo incontrato dal laser
  fill(200, 0, 0);

 

  //if (is_in_obstacle(x, y) == detected_obs && (detected_obs != -1)) {        
    /* se il laser e l'oggetto si trovano lungo 
     i lati dello stesso oggetto, same_obstacle è true */
  /*  same_obstacle = true;
  } else {
    same_obstacle = false;
  }
*/

//println(same_obstacle);
same_obstacle = false;

  // laser
  if (!same_obstacle)
  {
    stroke(180, 0, 0);
    circle(xi, yi, 5); //pallino finale laser
    stroke(180, 0, 0);
    strokeWeight(2);
    line(0, 0, xi, yi);
    stroke(0, 0, 255);
   // detect_vert(xi_0, yi_0);
  }
/*
  if (detected_obs == id_target) 
  { 
    popMatrix();
    vertex_found = true;
    return true;
  }
*/
  stroke(255);
  noStroke();
  popMatrix(); //mi riporto alle coordinate inerziali

  fill(0);
  alpha = (alpha + (2*PI)/num_iter) %(2*PI);

  return false;
}
