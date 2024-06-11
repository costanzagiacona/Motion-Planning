boolean scan(float x, float y, float len_max, color colore)
{    //x,y coordinate del robot rispetto a SR0, len_max = raggio max laser

  //xi,yi sono espresse rispetto a SR robot, xi_0, yi_0 rispetto a SR0
  float xi, yi, xi_0, yi_0;
  float len_x = posxsp[nfigurasp-1]/2;
  float len_y = posysp[nfigurasp-1]/2;
  boolean same_obstacle;
  int detected_obs;


  pushMatrix();
  translate(x, y);     //mi pongo nel SR del robot
  len_x = cos(alpha)*len_max; //modifico la posizione in base all'orientamento del robot
  len_y = sin(alpha)*len_max;


  //stroke(colore); // <-------------------- NON USATO
  stroke(#6DCEF0);

  fill(255);
  stroke(255);
  circle(len_x, len_y, 5);  //pallino bianco finale
  //figura(60, len_x, len_y, 0); //disegno robot

 //INTERSEZIONE CON  OSTACOLO
  //x,y inizio laser --- len_x,len_y fine laser
  float[] intersection_obstacles = intersectionObstacles(x, y, len_x, len_y); //possibile intersezione con ostacolo
  
  //INTERSEZIONE CON TAVOLO
  float[] intersection_wall = new float[3]; //intersezione tavolo
  
  if (nfigurasp == 1 || nfigurasp == 2) 
  {
    intersection_wall = intersectionWall_qr(x, y, 0, 0, len_x, len_y);
  } 
  else if (nfigurasp == 5) 
  {
    intersection_wall = intersectionWall_3v(x, y, 0, 0, len_x, len_y);
  } 
  else if(nfigurasp == 4) 
  {
    pushMatrix();
    //translate(-x,-y,0);
    intersection_wall = intersectionWall_c(x, y, 0, 0, len_x, len_y);
    //intersection_wall = intersectionWall_pol(x, y, 0, 0, len_x, len_y); //non funziona
    popMatrix();
  }
  else 
  {
    intersection_wall = intersectionWall_pol(x, y, 0, 0, len_x, len_y);
  }


//VERIFICA PRESENZA INTERSEZIONE
  if (intersection_obstacles[0] == 1) //intersezione con ostacolo
  {
    xi = intersection_obstacles[1];
    yi = intersection_obstacles[2];
    //println("intersezione ostacolo");
  } else
  {
    //intersection_wall[0];  dal momento che se non interseca un ostacolo  SICURAMENTE ci sarà un intersezione col bordo
    xi = intersection_wall[1];
    yi = intersection_wall[2];
    //println("intersezione tavolo --> misura tavolo x", posxsp[nfigurasp-1], " misure calcolate x ->>>", xi);
    //println("misura tavolo y",posysp[nfigurasp-1], " misure calcolate y ->>>", yi);
  }

  //coordinate di xi rispetto a SR0
  xi_0 = xi + x; //fine laser rispetto SR0
  yi_0 = yi + y;

  detected_obs = is_in_obstacle(xi_0, yi_0);        // ID dell'ostacolo incontrato dal laser
  //println("OSTACOLO TROVATO", detected_obs);
  //println("Il laser ha visto l'ostacolo ",detected_obs );
  fill(200, 0, 0);


//se il robot si trova sullo stesso ostacolo individuato dal laser
// se id_ostacolo in cui si trova il robot == id_ostacolo visto da laser
  if (is_in_obstacle(x, y) == detected_obs && (detected_obs != -1)) 
  {
  /* se il laser e l'oggetto si trovano lungo
   i lati dello stesso oggetto, same_obstacle è true quindi non viene utilizzato il laser poichè quell'oggetto è gia stato studiato*/
    same_obstacle = true; //robot e laser sono sullo stesso oggetto
    //println("stesso ostacolo, same_obstacle ->", same_obstacle);
    //println("Il robot e laser sono sullo stesso oggetto");
   } 
   else 
   {
   same_obstacle = false;
   }
   

  //println(same_obstacle);
  //same_obstacle = false;

  // laser
  if (!same_obstacle) //non sono sullo stesso ostacolo
  {
    stroke(180, 0, 0);
    circle(xi, yi, 5); //pallino finale laser
    stroke(180, 0, 0);
    //strokeWeight(2);
    line(0, 0, xi, yi); //laser
    stroke(0, 0, 255);
    detect_vert(xi_0, yi_0); //coordinate fine laser
  }
  
  if (detected_obs == id_target) //se ho trovato il target
   {
   popMatrix();
   //println("TARGET TROVATO", detected_obs);
   vertex_found = true;
   return true;
   }
   
  stroke(255);
  noStroke();
  popMatrix(); //mi riporto alle coordinate inerziali

  fill(0);
  alpha = (alpha + (2*PI)/num_iter) %(2*PI);
  //println("alpha -> ", alpha, "numero iter -> ", num_iter);

  return false; //non abbiamo trovato il target
}

/*La funzione detect_vert serve a individuare un possibile vertice lungo un percorso del laser.
Cerca di capire se il laser sta attraversando una linea verticale o se c'è una variazione nella direzione del percorso del laser
*/
//coordinate laser rispetto SR0
void detect_vert(float xi, float yi) //trova vertice -------------------------------------------------
{

  float m_i2_i1, m_i1_i; //pendenza retta
  float threshold = 1.0/100;

  /* condizioni di verticalità */

  if (x_prev[1] == x_prev[0]) 
  {
    // Se la x è uguale, la retta è verticale
    m_i2_i1 = 1000;
  } 
  else 
  {
    m_i2_i1 = (y_prev[1]-y_prev[0])/(x_prev[1]-x_prev[0]);
  }

  if (x_prev[1] == xi) 
  {
    // Se la x è uguale, la retta è verticale
    m_i1_i = 1000;
  } 
  else 
  {
    // Calcola la pendenza tra (xi,yi) e il punto precedente del percorso del laser
    m_i1_i = (yi - y_prev[1])/(xi - x_prev[1]);
  }

  /* Controlla se la differenza tra questa pendenza e la pendenza del segmento precedente supera una soglia
  e se la rotazione del laser (alpha) soddisfa una certa condizione */
  
  /* il valore 500 come upper bound è per trattare le coppie di punti a pendenza infinita */
  if (abs(m_i1_i - m_i2_i1)> threshold && (alpha >= 3*(2*PI)/num_iter)) 
  { 
    vertex_found = true;
    x_vert = x_prev[1];
    y_vert = y_prev[1];
  }

  // Aggiorna i punti considerati e continua a cercare un vertice
  x_prev[0] = x_prev[1];
  y_prev[0] = y_prev[1];
  x_prev[1] = xi;
  y_prev[1] = yi;
}
