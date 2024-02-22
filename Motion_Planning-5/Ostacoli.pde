class Ostacolo
{
  public int id; //numero ostacolo
  //posizione centro
  public float posx;
  public float posy;
  //dimensioni
  public float lato1;
  public float lato2;
  // numero vertici
  public int vertici;
  //orientamento
  public float alpha;
  //forma
  public int forma; //nfigura

  // presente o meno
  //flag per dire se abbiamo finito di crearlo o meno
  public boolean creato;

  


  //coordinate vertici ostacolo rispetto SR ost
  public float[] vert_array_SR_ost = new float[8];
  //coordinate vertici SR
  public float[] vert_SR0 = new float[8];
  //coordinate vertici ostacolo OMBRA rispetto SR ost
  public float[] vert_array_SR_ost_om = new float[8];
  //coordinate vertici SR
  public float[] vert_SR0_om = new float[8];


  //funzione che crea l'ostacolo
  Ostacolo(int n, float posx_o, float posy_o, float l1, float l2, float alpha_o, int nfigura)
  {
    pushMatrix();

    //assegno valori
    id = n;
    posx = posx_o;
    posy = posy_o;
    lato1 = l1;
    lato2 = l2;
    alpha = alpha_o;
    forma = nfigura;
    creato = true;
  

    //orientamento
    translate(posx_o, posy_o, 10); //10 posiziona l'ostacolo sul pavimento
    rotateZ(alpha);

   
    //fill(#A70202);
    noFill();


    //creazione ostacolo
    formaost(forma, l1, l2);


    //coordinate ostacolo rispetto a SR ostacolo
    //vertice 1
    vert_array_SR_ost[0] = -l1/2; //in basso a sx
    vert_array_SR_ost[1] = -l2/2;
    //vertice 2
    vert_array_SR_ost[2] = l1/2; //in basso a dx
    vert_array_SR_ost[3] = -l2/2;
    //vertice 3
    vert_array_SR_ost[4] = -l1/2; //in alto a sx
    vert_array_SR_ost[5] = l2/2;
    //vertice 4
    vert_array_SR_ost[6] = l1/2; //in alto a dx
    vert_array_SR_ost[7] = l2/2;

    //coordinate ostacolo rispetto SR0
    //vertice 1
    vert_SR0[0] = (-l1/2)*cos(alpha) - (-l2/2)*sin(alpha)+posx;
    vert_SR0[1] = (-l1/2)*cos(alpha) + (-l2/2)*sin(alpha)+posy;
    //vertice 2
    vert_SR0[2] = (l1/2)*cos(alpha) - (-l2/2)*sin(alpha)+posx;
    vert_SR0[3] = (l1/2)*cos(alpha) + (-l2/2)*sin(alpha)+posy;
    //vertice 3
    vert_SR0[4] = (-l1/2)*cos(alpha) - (l2/2)*sin(alpha)+posx;
    vert_SR0[5] = (-l1/2)*cos(alpha) + (l2/2)*sin(alpha)+posy;
    //vertice 4
    vert_SR0[6] = (l1/2)*cos(alpha) - (l2/2)*sin(alpha)+posx;
    vert_SR0[7] = (l1/2)*cos(alpha) + (l2/2)*sin(alpha)+posy;

  /* FORMULE
  Sono trasformazioni geometriche necessarie per convertire 
  le coordinate dell'oggetto dal sistema di riferimento ruotato a quello non ruotato.
  Quando lo spazio di lavoro è ruotato, bisogna applicare una trasformazione di 
  rotazione inversa alle coordinate del quadrato per riportarle al sistema di riferimento non ruotato.
  
  coordinate del sr non ruotato (tavolo)
  x' = cos(θ) * (x - x0) - sin(θ) * (y - y0) + x0 
  y' = sin(θ) * (x - x0) + cos(θ) * (y - y0) + y0
  
  x,y -> coordinate ostacolo ruotato rispetto al tavolo
  x0,y0 -> coordinate del punto intorno a cui ruoti (centro sr tavolo)
  θ -> angolo di rotazione
  
  */
  
  
  //ostacolo OMBRA
  //coordinate ostacolo rispetto a SR ostacolo ombra
    //vertice 1
    vert_array_SR_ost_om[0] = -l1/2-k; //in basso a sx
    vert_array_SR_ost_om[1] = -l2/2-k;
    //vertice 2
    vert_array_SR_ost_om[2] = l1/2+k; //in basso a dx
    vert_array_SR_ost_om[3] = -l2/2-k;
    //vertice 3
    vert_array_SR_ost_om[4] = -l1/2-k; //in alto a sx
    vert_array_SR_ost_om[5] = l2/2+k;
    //vertice 4
    vert_array_SR_ost_om[6] = l1/2+k; //in alto a dx
    vert_array_SR_ost_om[7] = l2/2+k;

    //coordinate ostacolo ombra rispetto SR0
    //vertice 1
    vert_SR0_om[0] = (-l1/2-k)*cos(alpha) - (-l2/2-k)*sin(alpha)+posx;
    vert_SR0_om[1] = (-l1/2-k)*cos(alpha) + (-l2/2+k)*sin(alpha)+posy;
    //vertice 2
    vert_SR0_om[2] = (l1/2+k)*cos(alpha) - (-l2/2-k)*sin(alpha)+posx;
    vert_SR0_om[3] = (l1/2+k)*cos(alpha) + (-l2/2+k)*sin(alpha)+posy;
    //vertice 3
    vert_SR0_om[4] = (-l1/2-k)*cos(alpha) - (l2/2-k)*sin(alpha)+posx;
    vert_SR0_om[5] = (-l1/2-k)*cos(alpha) + (l2/2+k)*sin(alpha)+posy;
    //vertice 4
    vert_SR0_om[6] = (l1/2+k)*cos(alpha) - (l2/2-k)*sin(alpha)+posx;
    vert_SR0_om[7] = (l1/2+k)*cos(alpha) + (l2/2+k)*sin(alpha)+posy;

    popMatrix();
  }
}


//Creazione ostacolo e aggiunto alla lista
void Ostacolo_creazione(int n, float posx_o, float posy_o, float l1, float l2, float alpha_o, int nfigura)
{
  //tipo   nome
  Ostacolo ost = new Ostacolo(n, posx_o, posy_o, l1, l2, alpha_o, nfigura);

  int num_ost = ostacolo_ArrayList.size();  //numero ostacolo è l'ultimo elemento inserito
  //println("dimensione lista", num_ost);

  // se siamo arrivati al numero massimo non inseriamo altri ostacoli
  if (num_ost <= numero_ostacoli) //evita di inserire più volte lo stesso ostacolo poichè il draw viene eseguito 60 volte al secondo 
  {
    ostacolo_ArrayList.add(ost); //qui inserisce l'ostacolo nella lista
    //println("inserito un ostacolo");
  }
  
  /*
  switch (nfigura)
  {
    case 1:
    ostacolo_ArrayList.get(numero_ostacoli).vertici = 4;
    break;
    
    case 2:
    ostacolo_ArrayList.get(numero_ostacoli).vertici = 4;
    break;
    
    case 3:
    ostacolo_ArrayList.get(numero_ostacoli).vertici = 4;
    break;
    
    case 4:
    ostacolo_ArrayList.get(numero_ostacoli).vertici = 30;
    break;
    
    case 5:
    ostacolo_ArrayList.get(numero_ostacoli).vertici = 3;
    break;
    
    case 6:
    ostacolo_ArrayList.get(numero_ostacoli).vertici = 4;
    break;
    
  }
  */
}
