//Intersezione tra due rette

float[] intersectionLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) 
{ //retta 1 (x1,y1)-----(x2,,y2) & retta 2 (x3,y3) ----- (x4,y4)

  //parametrizzazione delle rette rispetto ai parametri t e u
 

  float[] ret = new float[3];      //ret[0] = 1 se c'è intersezione, ret[1] e ret[2] sono le coordinate del pt di intersezione

  float t = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)); 
  float u = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1)); 
  
  //t ci dice a che altezza viene intersecata da u
  //u ci dice a che altezza viene intersecata da t
  
  //se t=0 -> intersezione t e u all'inizio di t
  //se t=1 -> intersezione t e u alla fine di t
  //se 0<t<1 -> l'intersezione è in un certo punto intermedio di t
  //stessa cosa per u

  //se entrambi compresi tra 0 e 1 c'è una intersezione, ovvero c'è una collisione:
  //u >= 0.05 significa che l'intersezione non può stare nell'origine della seconda retta 
  //(che per come passiamo i parametri noi è il raggio laser) ->> DA RIVEDEREEEEEEEEEEEEE

  if (t >=0 && t <= 1 && u >= 0.01 && u <= 1) 
  {

    ret[0] = 1;
    ret[1] = x1 + (t * (x2-x1));
    ret[2] = y1 + (t * (y2-y1));
    fill(255);
    noStroke();

    return ret;
  } 
  else //non c'è collisione
  {
    ret[0] = 0;
    ret[1] = 0;
    ret[2] = 0;
    return ret;
  }
}



//intersezione con il tavolo
float[] intersectionWall(float x, float y, float len_x, float len_y) {

  float[] dx = new float[3];
  float[] sx = new float[3];
  float[] up = new float[3];
  float[] down = new float[3];
 
  
  len_x = (ostacolo_ArrayList.get(numero_ostacoli-1)).lato1/2;
  len_y = (ostacolo_ArrayList.get(numero_ostacoli-1)).lato2/2;

  float[] wall_collision = new float[3];
  wall_collision[0] = 0; //presenza o meno della collisione
  wall_collision[1] = 0; //collisione in x
  wall_collision[2] = 0; //collisione in y
  
  //è sufficiente ci sia una sola collisione
  dx = intersectionLine(posxsp[nfigurasp-1]/2 - x, -posysp[nfigurasp-1]/2 - y, posxsp[nfigurasp-1]/2 - x, posysp[nfigurasp-1]/2 - y, 0, 0, len_x, len_y);
  if (dx[0] == 1) { //se ho una collisione a dx la salvo
    wall_collision[0] = 1;
    wall_collision[1] = dx[1];
    wall_collision[2] = dx[2];
  }
  sx = intersectionLine(-posxsp[nfigurasp-1]/2 - x, -posysp[nfigurasp-1]/2 - y, -posxsp[nfigurasp-1]/2 - x, posysp[nfigurasp-1]/2 - y, 0, 0, len_x, len_y);
  if (sx[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = sx[1];
    wall_collision[2] = sx[2];
  }
  up = intersectionLine(-posxsp[nfigurasp-1]/2 -x, -posysp[nfigurasp-1]/2 - y, posxsp[nfigurasp-1]/2 - x, -posysp[nfigurasp-1]/2 - y, 0, 0, len_x, len_y);
  if (up[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = up[1];
    wall_collision[2] = up[2];
  }
  down = intersectionLine(-posxsp[nfigurasp-1]/2 -x, posysp[nfigurasp-1]/2 - y, posxsp[nfigurasp-1]/2 - x, posysp[nfigurasp-1]/2 - y, 0, 0, len_x, len_y);
  if (down[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = down[1];
    wall_collision[2] = down[2];
  }

  return wall_collision;
}

/*
boolean collisioni () //posx ostacolo, posy ostacolo, lato1 spazio op, lato 2 spazio op, orientamento ostacolo
{
  float[] ost_collisioni = new float[ ostacolo_ArrayList.get(numero_ostacoli-1).vertici ]; //ogni ostacolo ha # vertici diverso
}
*/
