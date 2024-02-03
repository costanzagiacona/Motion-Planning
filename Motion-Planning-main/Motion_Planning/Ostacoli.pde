class Ostacolo
{
  public int id; //numero ostacolo
  //posizione centro
  public float posx;
  public float posy;
  //orientamento
  public float alpha;
  //forma
  public int forma; //nfigura
  
  // presente o meno
  //flag per dire se abbiamo finito di crearlo o meno
  public boolean flag;
  
  
  //funzione che crea l'ostacolo
  Ostacolo(int n, float posx_o, float posy_o, float alpha_o, int nfigura)
  {
    pushMatrix();
    
    //assegno valori
    id = n;
    posx = posx_o;
    posy = posy_o;
    alpha = alpha_o;
    forma = nfigura;
    
    
     //orientamento
     translate(posx_o, posy_o, 10); //10 posiziona l'ostacolo sul pavimento
     rotateZ(alpha);
     
     
    //creazione ostacolo
    formaost(forma);
   
    
    
    popMatrix();
  }
  
}


//Creazione ostacolo e aggiunto alla lista
void Ostacolo_creazione(int n, float posx_o, float posy_o, float alpha_o, int nfigura)
{
  //tipo   nome
  Ostacolo ost = new Ostacolo(n,posx_o,posy_o,alpha_o,nfigura);
  
  int num_ost = ostacolo_ArrayList.size();  //numero ostacolo è l'ultimo elemento inserito
  
  // se siamo arrivati al numero massimo non inseriamo altri ostacoli
  if (num_ost < MAX_OST) 
  {
    ostacolo_ArrayList.add(ost); //qui inserisce l'ostacolo nella lista
  }
  
}
