//variabili scanner
boolean s = false;   //variabile scanner
int num_iter = 2500;
float start_alpha = (2*PI)/num_iter;
float alpha = start_alpha;
float[] x_prev = {0, 0};   //coordinate dei punti i-1,i-2 RISPETTO A SR0
float[] y_prev = {0, 0};
float x_vert, y_vert;
boolean vertex_found = false;


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


  stroke(colore); // <-------------------- NON USATO
  stroke(#6DCEF0);

  fill(255);
  stroke(255);
  circle(len_x, len_y, 5);  //pallino bianco finale
  //figura(60, len_x, len_y, 0); //disegno robot

  //xi,yi sono le coordinate del punto verde sul foglio appunti progetto
  //xi,yi sono espresse rispetto a SR robot

  //x,y inizio laser --- len_x,len_y fine laser
  float[] intersection_obstacles = intersectionObstacles(x, y, len_x, len_y); //possibile intersezione con ostacolo
  
  float[] intersection_wall = new float[3]; //intersezione tavolo
  
  if (nfigurasp == 1 || nfigurasp == 2) {
    intersection_wall = intersectionWall_qr(x, y, 0, 0, len_x, len_y);
  } //possibile intersezione con ostacolo
  else if (nfigurasp == 5) {
    intersection_wall = intersectionWall_3v(x, y, 0, 0, len_x, len_y);
  } 
  else if(nfigurasp == 4) {
    pushMatrix();
    //translate(-x,-y,0);
    intersection_wall = intersectionWall_c(x, y, 0, 0, len_x, len_y);
    popMatrix();
  }
  else {
    intersection_wall = intersectionWall_pol(x, y, 0, 0, len_x, len_y);
  }


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
  fill(200, 0, 0);


//se il robot si trova sullo stesso ostacolo individuato dal laser
  if (is_in_obstacle(x, y) == detected_obs && (detected_obs != -1)) {
  /* se il laser e l'oggetto si trovano lungo
   i lati dello stesso oggetto, same_obstacle è true quindi non viene utilizzato il laser poichè quell'oggetto è gia stato studiato*/
    same_obstacle = true; //robot e laser sono sullo stesso oggetto
   } else {
   same_obstacle = false;
   }
   

  //println(same_obstacle);
  //same_obstacle = false;

  // laser
  if (!same_obstacle)
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
   vertex_found = true;
   return true;
   }
   
  stroke(255);
  noStroke();
  popMatrix(); //mi riporto alle coordinate inerziali

  fill(0);
  alpha = (alpha + (2*PI)/num_iter) %(2*PI);

  return false; //non abbiamo trovato il target
}

/*La funzione detect_vert serve a individuare un possibile vertice lungo un percorso del laser.
Cerca di capire se il laser sta attraversando una linea verticale o se c'è una variazione nella direzione del percorso del laser
*/
//coordinate laser rispetto SR0
void detect_vert(float xi, float yi) //trova vertice
{

  float m_i2_i1, m_i1_i; //pendenza retta
  float threshold = 1.0/100;

  /* condizioni di verticalità NON FUNZIONA FIXARE*/

  if (x_prev[1] == x_prev[0]) {
    // Se la x è uguale, la retta è verticale
    m_i2_i1 = 1000;
  } else {
    m_i2_i1 = (y_prev[1]-y_prev[0])/(x_prev[1]-x_prev[0]);
  }

  if (x_prev[1] == xi) {
    // Se la x è uguale, la retta è verticale
    m_i1_i = 1000;
  } else {
    // Calcola la pendenza tra (xi,yi) e il punto precedente del percorso del laser
    m_i1_i = (yi - y_prev[1])/(xi - x_prev[1]);
  }

  /* Controlla se la differenza tra questa pendenza e la pendenza del segmento precedente supera una soglia
  e se la rotazione del laser (alpha) soddisfa una certa condizione */
  
  /* il valore 500 come upper bound è per trattare le coppie di punti a pendenza infinita */
  if (abs(m_i1_i - m_i2_i1)> threshold && (alpha >= 3*(2*PI)/num_iter)) { 
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
