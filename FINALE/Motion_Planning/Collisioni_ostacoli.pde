/*----------------------------- POSIZIONAMENTO OSTACOLI ----------------------------------------*/ 

/* Funzione che, prese in ingresso le coordinate inerziali di un punto, resistuisce l'id
 dell'oggetto all'interno di cui si trova, oppure -1 se non appartiene a nessun oggetto */
int is_in_obstacle(float x_0, float y_0) //input - coordinate punto rispetto sistema di riferimento fisso SR0
{
  //x_1,y_1 sono le coordinate del punto rispetto al SR dell'ostacolo
  float x_1, y_1, beta, px, py,temp1,temp2;

  //valore di tolleranza numerica (perché sin e cos sono approssimati)
  float tol = 1.5+5;
  //float tol = 1.5;

  for (Ostacolo o : ostacolo_ArrayList) //per ogni ostacolo nella lista
  {
    beta = o.alpha; //orientamento ostacolo
    px = o.posx; //coordinata x ostacolo
    py = o.posy; //coordinata y ostacolo

    //portiamo il punto nel SR oggetto
    //trasformazione che fa ruotare un punto di beta, x_0 e y_0 coordinate punto da ruotare, px e py coordinate rispetto a sistema di rif. non inerziale
    x_1 = cos(beta)*(x_0 - px) + sin(beta)*(y_0 - py); //coordinata x punto nel SR oggetto
    y_1 = cos(beta)*(y_0 - py) + sin(beta)*(px - x_0); //coordinata y punto nel SR oggetto
    
    
    if (!o.is_t) 
    {
      //se l'ostacolo non è il target
      temp1 = o.lato1 + r_r;
      temp2 = o.lato2 + r_r;
    } 
    else
    {
      temp1 = o.lato1;
      temp2 = o.lato2;
    }


    //controlliamo se il punto si trova all'interno dell'ostacolo
    //if (abs(x_1) <= ((o.lato1)/2 + tol) && abs(y_1) <= ((o.lato2)/2 + tol))
    if (abs(x_1) <= ((temp1)/2 + tol) && abs(y_1) <= ((temp2)/2 + tol))
    {
      //println("sovrapposizione con ostacolo numero ", ob.id);
      return o.id;
    }
  }
  return -1;
}


//funzione che verifica se due ostacoli sono sovrapposti o se un ostacolo è fuori dallo spazio operativo
boolean sovrapposizione(float posx, float posy, float l1, float l2, float alpha) //x ostacolo, y ostacolo, lati ostacolo, orientamento ostacolo (nel SR ostacolo)
{

  float[] vert_ghost_obs;  // coordinate vertici ostacolo da istanziare
  float k_om = k/2;   // valore dell'ombra
  boolean v1 = false; //non ci sono sovrapposizioni

  //verifica se CENTRO ostacolo è all'interno dello spazio di lavoro
  float h = 0;
  float[] dx = new float[3];
  float[] sx = new float[3];
  float[] up = new float[3];
  float[] down = new float[3];
  float[] col_sp;  // sovrapposizione con tavolo
  
  float tol = 1.0;  
  float x_0, y_0, x_1, y_1;  // coordinate rispetto a SR0 e SR1

  //le calcoliamo e non le prendiamo dalla classe oggetto perché ancora non è stato istanziato
  //coordinate ostacolo rispetto SR0
  if (nfiguraost == 4) { // Se è un cerchio, dimensione vettore 12
    vert_ghost_obs = new float[12];
    vert_ghost_obs = vertici_ost_om(nfiguraost, l1+k_om, l2+k_om, x, y, alpha,k);
  } else if (nfiguraost == 5) { // Se è un triangolo dimensione vettore 6
    vert_ghost_obs = new float[6];
    vert_ghost_obs = vertici_ost_om(nfiguraost, l1+k_om, l2+k_om, x, y, alpha,k);
  } else { // Altrimenti, dimensione 8
    vert_ghost_obs = new float[8];
    vert_ghost_obs = vertici_ost_om(nfiguraost, l1+k_om, l2+k_om, x, y, alpha,k);
  }



  //----------------- SOVRAPPOSIZIONE CON TAVOLO----------------------
  /*
   Per vedere se l'oggetto esce dal tavolo si fa uno studio diviso in due parti:
     1 - controllo sui vertici per verificare se escono dal tavolo
     2 - controllo sul centro dell'oggetto per verificare se l'oggetto sia all'interno dello spazio di lavoro o meno
   Il controllo 2 è necessario poichè se l'oggetto si trova fuori dallo spazio di lavoro non deve essere istanziato, in questo caso i vertici non rilevano una sovrapposizione
   */

  switch(nfigurasp) //verifica sul centro dell'oggetto
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
    if (dx[0] == 1) { 
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


  //vertici
  for (int k = 0; k < vert_ghost_obs.length; k = k+2)
  {
    // uso la funzione di intersezione con sp per evitare che gli ostacoli vengano posizionati fuori dallo spazio di lavoro
    if (nfigurasp == 1 || nfigurasp == 2) 
    { // quadrato o rettangolo
      col_sp = intersectionWall_qr(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);  // input - centro dell'ostacolo, vertici ostacolo
      if (col_sp[0] == 1) println("collisioni tavolo 1,2");
    } 
    else if (nfigurasp == 5) 
    { // triangolo
      col_sp = intersectionWall_3v(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
      if (col_sp[0] == 1) println("collisioni tavolo 5");
    } 
    else if (nfigurasp == 4) 
    { // cerchio
      col_sp = intersectionWall_c(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
      if (col_sp[0] == 1) println("collisioni tavolo c");
    } 
    else 
    { // altri poligoni
      col_sp = intersectionWall_pol(0, 0, x, y, vert_ghost_obs[k], vert_ghost_obs[k+1]);
      if (col_sp[0] == 1) println("collisioni tavolo pol4");
    }

    if (col_sp[0] == 1)
    {
      v1 = true;
      return v1;
    }
  }

  //------------------------- SOVRAPPOSIZIONE OSTACOLI TRA LORO ---------------------------------
  
  /* verifica se un vertice dell'ostacolo da istanziare compenetra un ostacolo esistente */
  for (int i = 0; i < vert_ghost_obs.length; i=i+2) {
    if (is_in_obstacle(vert_ghost_obs[i], vert_ghost_obs[i+1]) != -1 ) {
      v1 = true;
      println("collisione con",is_in_obstacle(vert_ghost_obs[i], vert_ghost_obs[i+1]));
      circle(vert_ghost_obs[i], vert_ghost_obs[i+1], 40);
      return v1;
    }
  }
  
  /* verifica se l'ostacolo da inserire è compenetrato da vertici di un ostacolo esistente */
  //ostacolo OMBRA
  for (Ostacolo o : ostacolo_ArrayList) //per ogni ostacolo
  {
    for (int j = 0; j < o.num_vertici_ost; j = j+2) //controlliamo due vertici alla volta
    {
      //vertici nel SR0
      x_0 = o.vert_SR0_om[j];
      y_0 = o.vert_SR0_om[j+1];
      //stessi vertici nel SR1
      x_1 = cos(alpha)*(x_0 - posx) + sin(alpha)*(y_0 - posy);
      y_1 = cos(alpha)*(y_0 - posy) + sin(alpha)*(posx - x_0);
      //se i vertici di un ostacolo esistente si trovano all'interno dell'ostacolo che si sta provando ad istanziare
      if (abs(x_1) <= ((l1 + k/2)/2 + tol) && abs(y_1) <= ((l2 + k/2)/2 + tol)) // +k fa riferimento alla misura dell'ostacolo ombra
      {
        v1 = true;
        //println("Sovrapposizione ostacolo ombra con ostacolo", o.id);
        return v1;
      }
    }

    /* controllo centro ostacolo */
    //centro nel SR0
    x_0 = o.posx;
    y_0 = o.posy;
    //stesso centro nel SR1
    x_1 = cos(alpha)*(x_0 - posx) + sin(alpha)*(y_0 - posy);
    y_1 = cos(alpha)*(y_0 - posy) + sin(alpha)*(posx - x_0);
    //se il centro di un ostacolo esistente si trova all'interno dell'ostacolo che si sta provando ad istanziare
    if (abs(x_1) <= ((l1 + k)/2 + tol) && abs(y_1) <= ((l2 + k)/2 + tol)) // +k fa riferimento alla misura dell'ostacolo ombra
    {
      v1 = true;
      println("Sovrapposizione ostacolo ombra CENTRO");
      return v1;
    }
  }

  return v1;
}
