/*Funzioni per il posizionamento dell'ostacolo all'interno del tavolo e non sovrapposto ad altri ostacoli*/


/* funzione che, prese in ingresso le coordinate inerziali di un punto, resistuisce l'id
 dell'oggetto all'interno di cui si trova, oppure -1 se non appartiene a nessun oggetto */
int is_in_obstacle(float x_0, float y_0) //input - coordinate punto rispetto sistema di riferimento fisso SR0
{

  //x_1,y_1 sono le coordinate del punto rispetto al SR dell'ostacolo
  float x_1, y_1, beta, px, py;

  //valore di tolleranza numerica (perché sin e cos sono approssimati)
  float tol = 1.5;

  for (Ostacolo ob : ostacolo_ArrayList) //per ogni ostacolo nella lista
  {
    beta = ob.alpha; //orientamento ostacolo
    px = ob.posx; //coordinata x ostacolo
    py = ob.posy; //coordinata y ostacolo

    //portiamo il punto nel SR oggetto
    //trasformazione che fa ruotare un punto di beta, x_0 e y_0 coordinate punto da ruotare, px e py coordinate punto fisso
    x_1 = cos(beta)*(x_0 - px) + sin(beta)*(y_0 - py); //coordinata x punto nel SR oggetto
    y_1 = cos(beta)*(y_0 - py) + sin(beta)*(px - x_0); //coordinata y punto nel SR oggetto

    //controlliamo se il punto si trova all'interno dell'ostacolo
    if (abs(x_1) <= ((ob.lato1)/2 + tol) && abs(y_1) <= ((ob.lato2)/2 + tol))
    {
      println("sovrapposizione con ostacolo numero ", ob.id);
      return ob.id; //punto all'interno dell'ostacolo
    }
  }
  return -1;
}


//funzione che verifica se due ostacoli sono sovrapposti o se un ostacolo è fuori dallo spazio operativo
boolean sovrapposizione(float posx, float posy, float l1, float l2, float alpha) //x ostacolo, y ostacolo, lati ostacolo, orientamento ostacolo (nel SR ostacolo)
{
  /* qui verifica se l'ostacolo da inserire ha vertici che compenetrano un ostacolo esistente */
  float[] vert_ghost_obs = new float[8]; //le salviamo qui poichè l'ostacolo non è ancora stato istanziato

  //le calcoliamo e non le prendiamo dalla classe oggetto perchè ancora non è stato instanziato
  //coordinate ostacolo rispetto SR0
  //vertice 1
  vert_ghost_obs[0] = (-l1/2-k)*cos(alpha) - (-l2/2-k)*sin(alpha)+posx; //teniamo conto dell'ombra
  vert_ghost_obs[1] = (-l1/2-k)*cos(alpha) + (-l2/2+k)*sin(alpha)+posy;
  //vertice 2
  vert_ghost_obs[2] = (l1/2+k)*cos(alpha) - (-l2/2-k)*sin(alpha)+posx;
  vert_ghost_obs[3] = (l1/2+k)*cos(alpha) + (-l2/2-k)*sin(alpha)+posy;
  //vertice 3
  vert_ghost_obs[4] = (-l1/2-k)*cos(alpha) - (l2/2+k)*sin(alpha)+posx;
  vert_ghost_obs[5] = (-l1/2-k)*cos(alpha) + (l2/2+k)*sin(alpha)+posy;
  //vertice 4
  vert_ghost_obs[6] = (l1/2+k)*cos(alpha) - (l2/2+k)*sin(alpha)+posx;
  vert_ghost_obs[7] = (l1/2+k)*cos(alpha) + (l2/2+k)*sin(alpha)+posy;


  boolean v1 = false; //non ci sono sovrapposizioni

  //CON IL TAVOLO
  /*
 Per vedere se l'oggetto esce dal tavolo si fa uno studio diviso in due parti:
   1 - controllo sui vertici per verificare se escono dal tavolo
   2 - controllo sul centro dell'oggetto per verificare se l'oggetto sia all'interno dello spazio di lavoro o meno 
  Il controllo 2 è necessario poichè se l'oggetto si trova fuori dallo spazio di lavoro non deve essere istanziato, in questo caso i vertici non rilevano una sovrapposizione
   */


  //verifica se CENTRO ostacolo è all'interno dello spazio di lavoro
  float h = 0;
  float[] dx = new float[3];
  float[] sx = new float[3];
  float[] up = new float[3];
  float[] down = new float[3];


  switch(nfigurasp)
  {
  case 1: //quadrato
  case 2: //rettangolo
    if (x >= posxsp[nfigurasp-1]/2 || x <= - posxsp[nfigurasp-1]/2 )
    {
      println(" TAVOLO oggetto uscito x");
      v1 = true;
      return v1;
    }
    if (y >= posysp[nfigurasp-1]/2 || y <= - posysp[nfigurasp-1]/2 )
    {
      println(" TAVOLO oggetto uscito y");
      v1 = true;
      return v1;
    }
    break;

  case 3: //rombo
  case 6: //trapezio
    dx = intersectionLine(vertici_sp[0], vertici_sp[1], vertici_sp[2], vertici_sp[3], 0, 0, x, y); // v1-v2 -> in basso a sx ---- in basso a dx
    if (dx[0] == 1) { //se ho una collisione a dx la salvo
      println(" TAVOLO oggetto uscito dx");
      v1 = true;
      return v1;
    }

    sx = intersectionLine(vertici_sp[0], vertici_sp[1], vertici_sp[4], vertici_sp[5], 0, 0, x, y); //v1-v3 -> in basso a sx --- in alto a sx
    if (sx[0]==1) {
      println(" TAVOLO oggetto uscito sx");
      v1 = true;
      return v1;
    }

    up = intersectionLine(vertici_sp[6], vertici_sp[7], vertici_sp[4], vertici_sp[5], 0, 0, x, y); //v4-v3 -> in alto a dx --- in alto a sx
    if (up[0]==1) {
      println(" TAVOLO oggetto uscito up");
      v1 = true;
      return v1;
    }

    down = intersectionLine(vertici_sp[6], vertici_sp[7], vertici_sp[2], vertici_sp[3], 0, 0, x, y); //v4-v2 -> in alto a dx ---- in basso a dx
    if (down[0]==1) {
      println(" TAVOLO oggetto uscito down");
      v1 = true;
      return v1;
    }

    break;

  case 4: //cerchio
    if (x > posxsp[nfigurasp-1]/2.2 || x < - posxsp[nfigurasp-1]/2.2 ) {
      println(" TAVOLO oggetto uscito x");
      v1 = true;
      return v1;
    }
    if (y > posysp[nfigurasp-1]/2.2 || y < - posysp[nfigurasp-1]/2.2) {
      println(" TAVOLO oggetto uscito y");
      v1 = true;
      return v1;
    }
    break;

  case 5: //triangolo
    h = (posxsp[nfigurasp-1]*sqrt(3))/2;
    //x
    dx = intersectionLine(vertici_sp[0], vertici_sp[1], vertici_sp[2], vertici_sp[3], 0, 0, x, y); // v1-v2
    if (dx[0] == 1) {
      println(" TAVOLO oggetto uscito x");
      v1 = true;
      return v1;
    }
    sx = intersectionLine(vertici_sp[0], vertici_sp[1], vertici_sp[4], vertici_sp[5], 0, 0, x, y); //v1-v3
    if (sx[0]==1)
    {
      println(" TAVOLO oggetto uscito x");
      v1 = true;
      return v1;
    }

    //y
    if (y > h/2.6 || y < - h/1.6)
    {
      println(" TAVOLO oggetto uscito y");
      v1 = true;
      return v1;
    }

    break;
  }


  //intersezione lato oggetto con lato tavolo
  float[] col_sp;
  for (int k = 0; k < vert_ghost_obs.length; k = k+2)
  {
    stroke(0, 0, 255);
    //line(0, 0, x, y); //da centro SR0 a centro oggetto
    stroke(255, 0, 0);
    //line( x, y);
    // uso la funzione di intersezione con sp per evitare che gli ostacoli vengano posizionati fuori dallo spazio di lavoro
    if (nfigurasp == 1 || nfigurasp == 2) { // quadrato o rettangolo
      col_sp = intersectionWall_pol(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
      if (col_sp[0] == 1) println("collisioni tavolo 1,2");
    } else if (nfigurasp == 5) { // triangolo
      col_sp = intersectionWall_3v(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
      if (col_sp[0] == 1) println("collisioni tavolo 5");
    } else { // altri poligoni
      col_sp = intersectionWall_pol(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
      if (col_sp[0] == 1) println("collisioni tavolo pol4");
    }
    
    if (col_sp[0] == 1)
    {
      v1 = true;
      return v1;
    }
  }


  //CON ALTRI OSTACOLI
  
  /* qui verifica se l'ostacolo da inserire è compenetrato da vertici di un ostacolo esistente */
  //ostacolo OMBRA
  float tol = 1.0;
  float x_0, y_0, x_1, y_1;

  for (Ostacolo o : ostacolo_ArrayList) //per ogni ostacolo
  {
    for (int j = 0; j < o.num_vertici_ost; j  = j+2) //controlliamo due vertici alla volta
    {
      //vertici nel SR0
      x_0 = o.vert_SR0_om[j];
      y_0 = o.vert_SR0_om[j+1];
      //stessi vertici nel SR1
      x_1 = cos(alpha)*(x_0 - posx) + sin(alpha)*(y_0 - posy);
      y_1 = cos(alpha)*(y_0 - posy) + sin(alpha)*(posx - x_0);
      //se i vertici di un ostacolo esistente si trovano all'interno dell'ostacolo che si sta provando ad istanziare
      if (abs(x_1) <= ((l1 + k)/2 + tol) && abs(y_1) <= ((l2 + k)/2 + tol)) // +k fa riferimento alla misura dell'ostacolo ombra
      {
        v1 = true;
        println("Sovrapposizione ostacolo ombra");
        return v1;
      }
    }

    //controllo centro ostacolo
    //centro nel SR0
    x_0 = o.posx;
    y_0 = o.posy;
    //stesso centro nel SR1
    x_1 = cos(alpha)*(x_0 - posx) + sin(alpha)*(y_0 - posy);
    y_1 = cos(alpha)*(y_0 - posy) + sin(alpha)*(posx - x_0);
    //se il centro di un ostacolo esistente si trovano all'interno dell'ostacolo che si sta provando ad istanziare
    if (abs(x_1) <= ((l1 + k)/2 + tol) && abs(y_1) <= ((l2 + k)/2 + tol)) // +k fa riferimento alla misura dell'ostacolo ombra
    {
      v1 = true;
      println("Sovrapposizione ostacolo ombra CENTRO");
      return v1;
    }
  }

  return v1;
}
