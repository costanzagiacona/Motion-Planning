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
    px = ob.posx; //coordinata x robot 
    py = ob.posy; //coordinata y robot

    //portiamo il punto nel SR del robot
    //trasformazione che fa ruotare un punto di beta, x_0 e y_0 coordinate punto da ruotare, px e py coordinate punto fisso
    x_1 = cos(beta)*(x_0 - px) + sin(beta)*(y_0 - py); //coordinata x punto nel SR robot
    y_1 = cos(beta)*(y_0 - py) + sin(beta)*(px - x_0); //coordinata y punto nel SR robot


    //controlliamo se il punto si trova all'interno dell'ostacolo
    if (abs(x_1) <= ((ob.lato1)/2 + tol) && abs(y_1) <= ((ob.lato2)/2 + tol))
    {
      println("sovrapposizione con ostacolo numero ",ob.id);
      return ob.id; //punto all'interno dell'ostacolo
    }
  }

  return -1;
}


//funzione che verifica se due ostacoli sono sovrapposti o se un ostacolo è fuori dallo spazio operativo
boolean sovrapposizione(float posx, float posy, float l1, float l2, float alpha) //x ostacolo, y ostacolo, lati ostacolo, orientamento ostacolo
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

  //verifica se l'ostacolo è all'interno dello spazio di lavoro
  
  for (int k = 0; k < vert_ghost_obs.length; k++) //controllo che oggetto non esca dal tavolo
   {
   if (abs(vert_ghost_obs[k]) > posxsp[nfigurasp-1]/2)
   {
   v1 = true;
   //println("sovrapposizione TAVOLO x");
   return v1;
   }
   if (abs(vert_ghost_obs[k]) > posysp[nfigurasp-1]/2)
   {
   v1 = true;
   //println("sovrapposizione Tavolo y");
   return v1;
   }
   }


  float[] col_sp;

  for (int k = 0; k < vert_ghost_obs.length; k = k+2)
  {
    stroke(0,0,255);
    line(0, 0, x, y);
    stroke(255,0,0);
    line( x, y);
    // uso la funzione di intersezione con sp per evitare che gli ostacoli vengano posizionati fuori dallo spazio di lavoro
    if (nfigurasp == 1 || nfigurasp == 2) { // quadrato o rettangolo
      col_sp = intersectionWall_qr(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
      if (col_sp[0] == 1) println("collisioni tavolo 1,2");
    } else if (nfigurasp == 5) { // triangolo
      col_sp = intersectionWall_3v(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
     if (col_sp[0] == 1) println("collisioni tavolo 5");
    } else { // altri poligoni
      col_sp = intersectionWall_pol(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
      if (col_sp[0] == 1) println("collisioni tavolo pol4");
    }


    //println("collisioni -> ", col_sp[0], col_sp[1], col_sp[2]);

    //se il centro dell'oggetto è oltre il tavolo ho una SOVRAPPOSIZIONE --------------------------------
    //funzione che trova il centro in base alla figura
    
    if (col_sp[0] == 1)
    {
      v1 = true;
      return v1;
    }
  }
  
  //CON ALTRI OSTACOLI

  //verifica se esiste una sovrapposizione di ostacoli
  for (int i = 0; i < 8; i=i+2)
  { //controllo per ogni vertice
    if (is_in_obstacle(vert_ghost_obs[i], vert_ghost_obs[i+1]) != -1 )
    {
      v1 = true;
      println("sovrapposizione OSTACOLO");
      return v1;
    }
  }

  /* qui verifica se l'ostacolo da inserire è compenetrato da vertici di un ostacolo esistente */
  //ostacolo OMBRA
  float tol = 1.0;
  float x_0, y_0, x_1, y_1;

  for (Ostacolo o : ostacolo_ArrayList)
  {
    for (int j = 0; j < 8; j  = j+2)
    {
      x_0 = o.vert_SR0_om[j];
      y_0 = o.vert_SR0_om[j+1];
      x_1 = cos(alpha)*(x_0 - posx) + sin(alpha)*(y_0 - posy);
      y_1 = cos(alpha)*(y_0 - posy) + sin(alpha)*(posx - x_0);
      if (abs(x_1) <= ((l1 + k)/2 + tol) && abs(y_1) <= ((l2 + k)/2 + tol))
      {
        //controllo sull'ostacolo aumentato
        v1 = true;
        println("Sovrapposizione ostacolo ombra");
        return v1;
      }
    }
  }

  return v1;
}
