/*Funzioni per il posizionamento dell'ostacolo all'interno del tavolo e non sovrapposto ad altri ostacoli*/

/* funzione che, prese in ingresso le coordinate inerziali di un punto, resistuisce l'id
   dell'oggetto all'interno di cui si trova, oppure -1 se non appartiene a nessun oggetto */

int is_in_obstacle(float x_0, float y_0) //input - coordinate punto rispetto sistema di riferimento fisso
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
      return ob.id; //punto all'interno dell'ostacolo
    }
  }

  return -1;
}


//funzione che verifica se due ostacoli sono sovrapposti o se un ostacolo è fuori dallo spazio operativo
boolean sovrapposizione(float posx, float posy, float l1,float l2, float alpha) //input - x ostacolo, y ostacolo, lati ostacolo, orientamento ostacolo
{

  /* qui verifica se l'ostacolo da inserire ha vertici che compenetrano un ostacolo esistente */
  float[] vert_ghost_obs = new float[8]; //le salviamo qui poichè l'ostacolo non è ancora stato istanziato
  
  //coordinate ostacolo rispetto SR0
    //vertice 1
    vert_ghost_obs[0] = (-l1/2)*cos(alpha) - (-l2/2)*sin(alpha)+posx;
    vert_ghost_obs[1] = (-l1/2)*cos(alpha) + (-l2/2)*sin(alpha)+posy;
    //vertice 2
    vert_ghost_obs[2] = (l1/2)*cos(alpha) - (-l2/2)*sin(alpha)+posx;
    vert_ghost_obs[3] = (l1/2)*cos(alpha) + (-l2/2)*sin(alpha)+posy;
    //vertice 3
    vert_ghost_obs[4] = (-l1/2)*cos(alpha) - (l2/2)*sin(alpha)+posx;
    vert_ghost_obs[5] = (-l1/2)*cos(alpha) + (l2/2)*sin(alpha)+posy;
    //vertice 4
    vert_ghost_obs[6] = (l1/2)*cos(alpha) - (l2/2)*sin(alpha)+posx;
    vert_ghost_obs[7] = (l1/2)*cos(alpha) + (l2/2)*sin(alpha)+posy;
    

  boolean v1 = false; //non ci sono sovrapposizioni

  //verifica se l'ostacolo è all'interno dello spazio di lavoro
  for (int k = 0; k < vert_ghost_obs.length; k++) 
  {
    if (abs(vert_ghost_obs[k]) > posxsp[nfigurasp-1]/1.2)  //1.75 scelto tramite ispezione visiva 
    {
      v1 = true;
      return v1;
    }
    if (abs(vert_ghost_obs[k]) > posysp[nfigurasp-1]/1.2) 
    {
      v1 = true;
      return v1;
    }
  }

/*
  //verifica se esiste una sovrapposizione di ostacoli
  for (int i = 0; i < 8; i=i+2) 
  { //controllo per ogni vertice
    if (is_in_obstacle(vert_ghost_obs[i], vert_ghost_obs[i+1]) != -1 ) 
    {
      v1 = true;
      return v1;
    }
  }
*/
  return v1;
}
