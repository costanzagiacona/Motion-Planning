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
  //(che per come passiamo i parametri noi è il raggio laser)

  if (t >=0 && t <= 1 && u >= 0.01 && u <= 1)
  {

    ret[0] = 1;
    ret[1] = x1 + (t * (x2-x1));
    ret[2] = y1 + (t * (y2-y1));
    fill(255);
    noStroke();

    return ret;
  } else //non c'è collisione
  {
    ret[0] = 0;
    ret[1] = 0;
    ret[2] = 0;
    return ret;
  }
}


//intersezione con il tavolo QUADRATO E RETTANGOLO
float[] intersectionWall_qr(float x, float y, float cx, float cy, float len_x, float len_y) {

  float[] dx = new float[3];
  float[] sx = new float[3];
  float[] up = new float[3];
  float[] down = new float[3];

  /*qui il confronto con il min non serve perchè il robot sta dentro al tavolo, non vedrà mai due bordi contemporaneamente
   */

  float[] wall_collision = new float[3];
  wall_collision[0] = 0; //presenza o meno della collisione
  wall_collision[1] = 0; //collisione in x
  wall_collision[2] = 0; //collisione in y

  //è sufficiente ci sia una sola collisione
  dx = intersectionLine(posxsp[nfigurasp-1]/2 - x, -posysp[nfigurasp-1]/2 - y, posxsp[nfigurasp-1]/2 - x, posysp[nfigurasp-1]/2 - y, cx, cy, len_x, len_y);
  if (dx[0] == 1) { //se ho una collisione a dx la salvo
    wall_collision[0] = 1;
    wall_collision[1] = dx[1];
    wall_collision[2] = dx[2];
  }
  sx = intersectionLine(-posxsp[nfigurasp-1]/2 - x, -posysp[nfigurasp-1]/2 - y, -posxsp[nfigurasp-1]/2 - x, posysp[nfigurasp-1]/2 - y, cx, cy, len_x, len_y);
  if (sx[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = sx[1];
    wall_collision[2] = sx[2];
  }
  up = intersectionLine(-posxsp[nfigurasp-1]/2 -x, -posysp[nfigurasp-1]/2 - y, posxsp[nfigurasp-1]/2 - x, -posysp[nfigurasp-1]/2 - y, cx, cy, len_x, len_y);
  if (up[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = up[1];
    wall_collision[2] = up[2];
  }
  down = intersectionLine(-posxsp[nfigurasp-1]/2 -x, posysp[nfigurasp-1]/2 - y, posxsp[nfigurasp-1]/2 - x, posysp[nfigurasp-1]/2 - y, cx, cy, len_x, len_y);
  if (down[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = down[1];
    wall_collision[2] = down[2];
  }

  return wall_collision;
}

/*
 v1 ----- v2
 |         |
 |         |
 v3 ----- v4
 */

//intersezione con il tavolo POLIGONI
float[] intersectionWall_pol(float x, float y, float cx, float cy, float len_x, float len_y)
{
  float[] dx = new float[3];
  float[] sx = new float[3];
  float[] up = new float[3];
  float[] down = new float[3];

  /*qui il confronto con il min non serve perchè il robot sta dentro al tavolo, non vedrà mai due bordi contemporaneamente
   */

  float[] wall_collision = new float[3];
  wall_collision[0] = 0; //presenza o meno della collisione
  wall_collision[1] = 0; //collisione in x
  wall_collision[2] = 0; //collisione in y

  //line(vertici_sp[0] - x, vertici_sp[1] - y, vertici_sp[2] - x, vertici_sp[3] - y);
  //è sufficiente ci sia una sola collisione
  dx = intersectionLine(vertici_sp[0] - x, vertici_sp[1] - y, vertici_sp[2] - x, vertici_sp[3] - y, cx, cy, len_x, len_y); // v1-v2 -> in basso a sx ---- in basso a dx
  if (dx[0] == 1) { //se ho una collisione a dx la salvo
    wall_collision[0] = 1;
    wall_collision[1] = dx[1];
    wall_collision[2] = dx[2];
  }

  sx = intersectionLine(vertici_sp[0] -x, vertici_sp[1] -y, vertici_sp[4] -x, vertici_sp[5] - y, cx, cy, len_x, len_y); //v1-v3 -> in basso a sx --- in alto a sx
  if (sx[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = sx[1];
    wall_collision[2] = sx[2];
  }

  up = intersectionLine(vertici_sp[6] -x, vertici_sp[7] -y, vertici_sp[4] -x, vertici_sp[5] - y, cx, cy, len_x, len_y); //v4-v3 -> in alto a dx --- in alto a sx
  if (up[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = up[1];
    wall_collision[2] = up[2];
  }

  down = intersectionLine(vertici_sp[6] -x, vertici_sp[7] -y, vertici_sp[2] -x, vertici_sp[3] - y, cx, cy, len_x, len_y); //v4-v2 -> in alto a dx ---- in basso a dx
  if (down[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = down[1];
    wall_collision[2] = down[2];
  }

  return wall_collision;
}

/*
      v1
 /    \
 /      \
 v3 ---- v2
 */

//intersezione tavolo TRIANGOLO (3 vertici)
float[] intersectionWall_3v(float x, float y, float cx, float cy, float len_x, float len_y)
{
  float[] dx = new float[3];
  float[] sx = new float[3];
  float[] down = new float[3];

  /*qui il confronto con il min non serve perchè il robot sta dentro al tavolo, non vedrà mai due bordi contemporaneamente */

  float[] wall_collision = new float[3];
  wall_collision[0] = 0; //presenza o meno della collisione
  wall_collision[1] = 0; //collisione in x
  wall_collision[2] = 0; //collisione in y

  //è sufficiente ci sia una sola collisione
  dx = intersectionLine(vertici_sp[0] - x, vertici_sp[1] - y, vertici_sp[2] - x, vertici_sp[3] - y, cx, cy, len_x, len_y); // v1-v2
  if (dx[0] == 1) { //se ho una collisione a dx la salvo
    wall_collision[0] = 1;
    wall_collision[1] = dx[1];
    wall_collision[2] = dx[2];
  }

  sx = intersectionLine(vertici_sp[0] -x, vertici_sp[1] -y, vertici_sp[4] -x, vertici_sp[5] - y, cx, cy, len_x, len_y); //v1-v3
  if (sx[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = sx[1];
    wall_collision[2] = sx[2];
  }

  down = intersectionLine(vertici_sp[4] -x, vertici_sp[5] -y, vertici_sp[2] -x, vertici_sp[3] - y, cx, cy, len_x, len_y); //v3-v2
  if (down[0]==1) {
    wall_collision[0] = 1;
    wall_collision[1] = down[1];
    wall_collision[2] = down[2];
  }

  return wall_collision;
}


//intersezione tavolo CERCHIO
float[] intersectionWall_c(float x, float y, float cx, float cy, float len_x, float len_y)
{
  float[] intersection = new float[3];
  float[] wall_collision = new float[3];
  wall_collision[0] = 0; //presenza o meno della collisione
  wall_collision[1] = 0; //collisione in x
  wall_collision[2] = 0; //collisione in y

  for (int i = 0; i < 12; i=i+4) //aumentando il numero dei vertici viene più preciso lo scan (6 vertici)
  {

    intersection = intersectionLine(vertici_cerchio[i]-x, vertici_cerchio[i+1]-y, vertici_cerchio[i+2]-x, vertici_cerchio[i+3]-y, cx, cy, len_x, len_y); //v3-v2
    if (intersection[0]==1)
    {

      wall_collision[0] = 1;
      wall_collision[1] = intersection[1];
      wall_collision[2] = intersection[2];
      return wall_collision;
    }
    intersection = intersectionLine(vertici_cerchio[i+2]-x, vertici_cerchio[i+3]-y, vertici_cerchio[i+4]-x, vertici_cerchio[i+5]-y, cx, cy, len_x, len_y); //v3-v2
    if (intersection[0]==1)
    {

      wall_collision[0] = 1;
      wall_collision[1] = intersection[1];
      wall_collision[2] = intersection[2];
      return wall_collision;
    }
  }

  return wall_collision;
}


/*il seguente blocco di controllo verifica se c'è un'intersezione di ritorno dalle intersectionLine con i contorni degli ostacoli.
 in particolare se la 0esima posizione sugli array è pari a 1, significa che c'è collisione, e le variabili globali intersectionX e intersection Y
 verranno impostate pari ai float in posizione 1 e 2. poi, tale valore sarà confrontato con i ritorni dalle collisioni successive, per tenere
 in memoria solamente la collisione con il bordo più vicino al robot */

float[] intersectionObstacles(float x, float y, float len_x, float len_y) //x,y posizione robot mentre lenx,leny sono le dimensioni del robot
{
  float[] dx = new float[3];
  float[] sx = new float[3];
  float[] up = new float[3];
  float[] down = new float[3];

  float[] intersection = new float[3];
  float[] closest_collision = new float[3];
  closest_collision[0] = 0;
  closest_collision[1] = laser_len; //raggio laser
  closest_collision[2] = laser_len;

  /* prima verifica per ogni ostacolo se il raggio attraversa l'ostacolo, se vede più punti di intersezione si ferma a quello più vicino a lui*/

  for (int i=0; i< ostacolo_ArrayList.size(); i++) //per ogni ostacolo
  {

    Ostacolo o = ostacolo_ArrayList.get(i);
    //l'uso di -x e -y serve a trasformare le coordinate assolute dell'ostacolo in coordinate relative rispetto
    //alla posizione corrente del robot. Questo è fondamentale per il calcolo delle intersezioni e
    //per determinare la posizione dell'ostacolo rispetto al robot in un sistema di coordinate relativo al robot stesso.

    if (o.forma == 5) //triangolo
    {
      //println("COLLISIONI SCAN -> intersezione ostacolo TRIANGOLO", closest_collision[0]);
      /*qui il confronto con il min non serve perchè il robot sta dentro al tavolo, non vedrà mai due bordi contemporaneamente */

      //è sufficiente ci sia una sola collisione
      dx = intersectionLine(o.vert_SR0_om[0] - x, o.vert_SR0_om[1] - y, o.vert_SR0_om[2] - x, o.vert_SR0_om[3] - y, 0, 0, len_x, len_y); // v1-v2
      if (dx[0] == 1) { //se ho una collisione a dx la salvo
      if (min_distance(dx[1], dx[2], closest_collision[1], closest_collision[2])){
        closest_collision[0] = 1;
        closest_collision[1] = dx[1];
        closest_collision[2] = dx[2];
      }
      }

      sx = intersectionLine(o.vert_SR0_om[0] -x, o.vert_SR0_om[1] -y, o.vert_SR0_om[4] -x, o.vert_SR0_om[5] - y, 0, 0, len_x, len_y); //v1-v3
      if (sx[0]==1) {
        if (min_distance(sx[1], sx[2], closest_collision[1], closest_collision[2])) {
        closest_collision[0] = 1;
        closest_collision[1] = sx[1];
        closest_collision[2] = sx[2];
        }
      }

      down = intersectionLine(o.vert_SR0_om[4] -x, o.vert_SR0_om[5] -y, o.vert_SR0_om[2] -x, o.vert_SR0_om[3] - y, 0, 0, len_x, len_y); //v3-v2
      if (down[0]==1) {
        if (min_distance(down[1], down[2], closest_collision[1], closest_collision[2])){
        closest_collision[0] = 1;
        closest_collision[1] = down[1];
        closest_collision[2] = down[2];
        }
      }
    } else if (o.forma == 4) //cerchio
    {
      //println("COLLISIONI SCAN -> intersezione ostacolo CERCHIO", closest_collision[0]);
      //closest_collision = intersectionObstacle_c(x, y, len_x, len_y);
       for (int ii = 0; ii < 8; ii=ii+4) //aumentando il numero dei vertici viene più preciso lo scan (6 vertici)
  {
    intersection = intersectionLine(o.vert_SR0_om[ii]-x, o.vert_SR0_om[ii+1]-y, o.vert_SR0_om[ii+2]-x, o.vert_SR0_om[ii+3]-y, 0, 0, len_x, len_y);
    if (intersection[0] == 1)
    {
      if (min_distance(intersection[1], intersection[2], closest_collision[1], closest_collision[2])) {
        closest_collision[0] = 1;
        closest_collision[1] = intersection[1]; //se c'è ostacolo il raggio del laser diminuisce e non oltrepassa l'ostacolo
        closest_collision[2] = intersection[2];
      }
    }

    intersection = intersectionLine(o.vert_SR0_om[ii+2]-x, o.vert_SR0_om[ii+3]-y, o.vert_SR0_om[ii+4]-x, o.vert_SR0_om[ii+5]-y, 0, 0, len_x, len_y);
    if (intersection[0] == 1)
    {
      if (min_distance(intersection[1], intersection[2], closest_collision[1], closest_collision[2])) {
        closest_collision[0] = 1;
        closest_collision[1] = intersection[1]; //se c'è ostacolo il raggio del laser diminuisce e non oltrepassa l'ostacolo
        closest_collision[2] = intersection[2];
      }
    }
  }
  
    } else { //altri
    //println("COLLISIONI SCAN -> intersezione ostacolo POLIGONI", closest_collision[0]);

      sx = intersectionLine(o.vert_SR0_om[0] -x, o.vert_SR0_om[1] -y, o.vert_SR0_om[4] -x, o.vert_SR0_om[5] - y, 0, 0, len_x, len_y);
      if (sx[0]==1) {
        //println("intersezione ostacolo vertice sx");
        //println(sx[1], sx[2], closest_collision[1], closest_collision[2]);
        if (min_distance(sx[1], sx[2], closest_collision[1], closest_collision[2])) {
          closest_collision[0] = 1;
          closest_collision[1] = sx[1]; //se c'è ostacolo il raggio del laser diminuisce e non oltrepassa l'ostacolo
          closest_collision[2] = sx[2];
        }
      }
      dx = intersectionLine(o.vert_SR0_om[0] - x, o.vert_SR0_om[1] - y, o.vert_SR0_om[2] - x, o.vert_SR0_om[3] - y, 0, 0, len_x, len_y);
      if (dx[0]==1) {
        //println("intersezione ostacolo vertice dx");
        // println(dx[1], dx[2], closest_collision[1], closest_collision[2]);
        if (min_distance(dx[1], dx[2], closest_collision[1], closest_collision[2])) {
          closest_collision[0] = 1;
          closest_collision[1] = dx[1];
          closest_collision[2] = dx[2];
        }
      }
      up = intersectionLine(o.vert_SR0_om[6] -x, o.vert_SR0_om[7] -y, o.vert_SR0_om[4] -x, o.vert_SR0_om[5] - y, 0, 0, len_x, len_y);
      if (up[0]==1) {
        //println("intersezione ostacolo vertice up");
        // println(up[1], up[2], closest_collision[1], closest_collision[2]);
        if (min_distance(up[1], up[2], closest_collision[1], closest_collision[2])) {
          closest_collision[0] = 1;
          closest_collision[1] = up[1];
          closest_collision[2] = up[2];
        }
      }
      down = intersectionLine(o.vert_SR0_om[6] -x, o.vert_SR0_om[7] -y, o.vert_SR0_om[2] -x, o.vert_SR0_om[3] - y, 0, 0, len_x, len_y);
      if (down[0]==1) {
        //println("intersezione ostacolo vertice down");
        // println(down[1], down[2], closest_collision[1], closest_collision[2]);
        if (min_distance(down[1], down[2], closest_collision[1], closest_collision[2])) {
          closest_collision[0] = 1;
          closest_collision[1] = down[1];
          closest_collision[2] = down[2];
        }
      }
    }
  }
  return closest_collision;
}


boolean min_distance(float x1, float y1, float x2, float y2)
{
  if (sqrt(pow(x1, 2) + pow(y1, 2)) < sqrt(pow(x2, 2) + pow(y2, 2)))  //quale tra i due punti P1=(x1,y1) e P2=(x2,y2) è più vicino
  {
    return true;
  } else
  {
    return false;
  }
}
