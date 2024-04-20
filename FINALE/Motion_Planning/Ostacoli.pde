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
  public int num_vertici_ost;
  //orientamento
  public float alpha;
  //nfigura
  public int forma;
  // se è il target
  public boolean is_t;

  //modifica ombra
  public float ombra_k;

  //coordinate vertici ostacolo rispetto SR ostacolo
  public float[] vert_array_SR_ost = new float[8];
  //coordinate vertici SR0
  public float[] vert_SR0 = new float[8];
  //coordinate vertici ostacolo OMBRA rispetto SR ostacolo
  public float[] vert_array_SR_ost_om = new float[8];
  //coordinate vertici SR0
  public float[] vert_SR0_om;


  //funzione che crea l'ostacolo
  Ostacolo(int n, float posx_o, float posy_o, float l1, float l2, float alpha_o, int nfigura, boolean target, float k)
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
    is_t = target;
    ombra_k = k;

    //orientamento
    translate(posx_o, posy_o, 5); //5 posiziona l'ostacolo sul pavimento
    rotateZ(alpha);

    //il target e gli ostacoli hanno colori diversi
    //if(target == false) fill(#A70202);
    //else fill(#2AB74C);
    noFill();

    //if ( nfigura == 4) l1 = l1/2;

    //creazione ostacolo
    formaost(forma, l1, l2);

    //ombra
    pushMatrix();
    noFill();
    //fill(#C6C4C0); //grigio
    translate(0, 0, -10);
    formaost(forma, l1+k, l2+k);
    popMatrix();

    popMatrix();

    //VERTICI
    //in base alla figura abbiamo diversi casi

    // Inizializzazione dell'array con la dimensione desiderata
    if (nfigura == 4)
    { //CERCHIO
      vert_SR0_om = new float[14];  // 14 per memorizzare come ultimo vertice [12][13] il primo [0][1]
      vert_SR0_om = vertici_ost_om(nfigura, l1, l2, posx, posy, alpha, ombra_k); //funzione sotto
      num_vertici_ost = 12;
      //println(vert_SR0_om);
    } else if (nfigura == 5)
    { //TRIANGOLO
      vert_SR0_om = new float[6];
      vert_SR0_om = vertici_ost_om(nfigura, l1, l2, posx, posy, alpha, ombra_k);
      num_vertici_ost = 6;
    } else
    { //ALTRIMENTI
      vert_SR0_om = new float[8];
      vert_SR0_om = vertici_ost_om(nfigura, l1, l2, posx, posy, alpha, ombra_k);
      num_vertici_ost = 8;
      //println(vert_SR0_om);
    }
  }
}


//Creazione ostacolo e aggiunto alla lista
void Ostacolo_creazione(int n, float posx_o, float posy_o, float l1, float l2, float alpha_o, int nfigura, boolean target, float k)
{
  //tipo   nome
  Ostacolo ost = new Ostacolo(n, posx_o, posy_o, l1, l2, alpha_o, nfigura, target, k);

  int num_ost = ostacolo_ArrayList.size();  //numero ostacolo è l'ultimo elemento inserito
  //println("dimensione lista", num_ost);

  // se siamo arrivati al numero massimo non inseriamo altri ostacoli (verifica in interazioni)
  if (num_ost < numero_ostacoli) //evita di inserire più volte lo stesso ostacolo poichè il draw viene eseguito 60 volte al secondo
  {
    ostacolo_ArrayList.add(ost); //qui inserisce l'ostacolo nella lista
    //println("inserito ostacolo ", n);
  }
}

/* FORMULE VERTICI
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

float[] vertici_ost_om(int nfigura, float l1, float l2, float posx, float posy, float alpha, float k) //SR0
{
  float h=0;
  float d=0;
  float[] vertici_ost_om;

  if (nfigura == 4)
  { //CERCHIO
    vertici_ost_om = new float[14]; // sono 14 e non 12 perché in questo modo l'ultimo vertice si ricollega al primo [0][1]
  } else if (nfigura == 5)
  { //TRIANGOLO
    vertici_ost_om = new float[6];
  } else
  { // ALTRIMENTI
    vertici_ost_om = new float[8];
  }


  float k_om = k/2; //diviso due perchè l'oggetto aumenta di k, quindi abbiamo k/2 su l1 e k/2 su l2
  switch(nfigura)
  {
  case 1: //QUADRATO
    //coordinate ostacolo rispetto SR0

    // vertice 1 (in basso a sinistra)
    vertici_ost_om[0] = posx + (-l1/2 - k_om) * cos(alpha) - (-l1/2 - k_om) * sin(alpha);
    vertici_ost_om[1] = posy + (-l1/2 - k_om) * sin(alpha) + (-l1/2 - k_om) * cos(alpha);

    // vertice 2 (in basso a destra)
    vertici_ost_om[2] = posx + (l1/2 + k_om) * cos(alpha) - (-l1/2 - k_om) * sin(alpha);
    vertici_ost_om[3] = posy + (l1/2 + k_om) * sin(alpha) + (-l1/2 - k_om) * cos(alpha);

    // vertice 3 (in alto a sinistra)
    vertici_ost_om[4] = posx + (-l1/2 - k_om) * cos(alpha) - (l1/2 + k_om) * sin(alpha);
    vertici_ost_om[5] = posy + (-l1/2 - k_om) * sin(alpha) + (l1/2 + k_om) * cos(alpha);

    // vertice 4 (in alto a destra)
    vertici_ost_om[6] = posx + (l1/2 + k_om) * cos(alpha) - (l1/2 + k_om) * sin(alpha);
    vertici_ost_om[7] = posy + (l1/2 + k_om) * sin(alpha) + (l1/2 + k_om) * cos(alpha);
    /*
    //stampa
     fill(0, 255, 0); //VERDE
     pushMatrix();
     translate(vertici_ost_om[0], vertici_ost_om[1]);
     rotateZ(alpha);
     //rotateZ(PI);
     noStroke();
     sphere(5);
     popMatrix();
     
     fill(#222EF2); ///BLU
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[2], vertici_ost_om[3]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F222F2); //ROSA
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[4], vertici_ost_om[5]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F4FA56); //GIALLO
     noStroke();
     pushMatrix();
     translate(vertici_ost_om[6], vertici_ost_om[7]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     */

    break;

  case 2: //RETTANGOLO
    //coordinate ostacolo rispetto SR0

    // vertice 1 (in basso a sinistra)
    vertici_ost_om[0] = posx + (-l1/2 - k_om) * cos(alpha) - (-l2/2 - k_om) * sin(alpha);
    vertici_ost_om[1] = posy + (-l1/2 - k_om) * sin(alpha) + (-l2/2 - k_om) * cos(alpha);

    // vertice 2 (in basso a destra)
    vertici_ost_om[2] = posx + (l1/2 + k_om) * cos(alpha) - (-l2/2 - k_om) * sin(alpha);
    vertici_ost_om[3] = posy + (l1/2 + k_om) * sin(alpha) + (-l2/2 - k_om) * cos(alpha);

    // vertice 3 (in alto a sinistra)
    vertici_ost_om[4] = posx + (-l1/2 - k_om) * cos(alpha) - (l2/2 + k_om) * sin(alpha);
    vertici_ost_om[5] = posy + (-l1/2 - k_om) * sin(alpha) + (l2/2 + k_om) * cos(alpha);

    // vertice 4 (in alto a destra)
    vertici_ost_om[6] = posx + (l1/2 + k_om) * cos(alpha) - (l2/2 + k_om) * sin(alpha);
    vertici_ost_om[7] = posy + (l1/2 + k_om) * sin(alpha) + (l2/2 + k_om) * cos(alpha);
    /*
    //stampa
     fill(0, 255, 0); //VERDE
     pushMatrix();
     translate(vertici_ost_om[0], vertici_ost_om[1]);
     rotateZ(alpha);
     //rotateZ(PI);
     noStroke();
     sphere(5);
     popMatrix();
     
     fill(#222EF2); ///BLU
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[2], vertici_ost_om[3]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F222F2); //ROSA
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[4], vertici_ost_om[5]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F4FA56); //GIALLO
     noStroke();
     pushMatrix();
     translate(vertici_ost_om[6], vertici_ost_om[7]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     */
    break;

  case 3: //ROMBO
    //diagonale rombo
    d = sqrt(pow(l1+k_om, 2)+pow(l2+k_om, 2));
    //k_om = k_om/1.5;

    // vertice 1
    vertici_ost_om[0] = posx + 0 * cos(alpha) - (d / 2.5) * sin(alpha); // in basso
    vertici_ost_om[1] = posy + 0 * sin(alpha) + (d / 2.5) * cos(alpha);

    // vertice 2
    vertici_ost_om[2] = posx + (d / 2.7) * cos(alpha) - 0 * sin(alpha); // dx
    vertici_ost_om[3] = posy + (d / 2.7) * sin(alpha) + 0 * cos(alpha);

    // vertice 3
    vertici_ost_om[4] = posx + 0 * cos(alpha) - (-d / 2.5) * sin(alpha); // sx
    vertici_ost_om[5] = posy + 0 * sin(alpha) + (-d / 2.5) * cos(alpha);

    // vertice 4
    vertici_ost_om[6] = posx - (d / 2.7) * cos(alpha) - 0 * sin(alpha); // avanti, quello lontano
    vertici_ost_om[7] = posy - (d / 2.7) * sin(alpha) + 0 * cos(alpha);
    /*
    //stampa
     fill(0, 255, 0); //VERDE
     pushMatrix();
     translate(vertici_ost_om[0], vertici_ost_om[1]);
     rotateZ(alpha);
     //rotateZ(PI);
     noStroke();
     sphere(5);
     popMatrix();
     
     fill(#222EF2); ///BLU
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[2], vertici_ost_om[3]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F222F2); //ROSA
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[4], vertici_ost_om[5]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F4FA56); //GIALLO
     noStroke();
     pushMatrix();
     translate(vertici_ost_om[6], vertici_ost_om[7]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     */

    break;

  case 4: //CERCHIO
    /*Calcola l'angolo in radianti per ogni lato della figura.
     Divide 360 gradi per il numero di vertici per ottenere l'angolo.*/
    //6 -> numero vertici
    float angle = -360 / 12; //angolo tra due vertici consecutivi in un esagono (12 perchè poi lo moltiplichiamo in x e y per multipli di 2)
    float x = 0, y = 0;
    //12 perché abbiamo 6 x e 6 y
    for (int i = 0; i < 14; i=i+2) // i+2 perchè calcoliamo allo stesso tempo x e y
      // arriaviamo fino a 22 perché altrimenti andiamo fuori dall'array
      //aumentando il numero dei vertici viene più preciso lo scan
    {
      x = cos(radians(i * angle)) * (l1/2+k_om);
      y = sin(radians(i * angle)) * (l1/2+k_om);
      //vertici_ost_om[i] = (x+k)*cos(alpha) - (y+k)*sin(alpha)+posx;
      //vertici_ost_om[i+1] = (x+k)*cos(alpha) + (y+k)*sin(alpha)+posy;
      vertici_ost_om[i] = x+posx;
      vertici_ost_om[i+1] = y+posy;
      //println(vertici_cerchio[i], vertici_cerchio[i+1]);
      /*
      pushMatrix();
       translate(vertici_ost_om[i], vertici_ost_om[i+1]);
       stroke(255, 0, 0);
       sphere(5);
       popMatrix();
       */
    }
    // aggiungo manualmente gli ultimi due vertici
    vertici_ost_om[12] = vertici_ost_om[0]; // x primo vertice
    vertici_ost_om[13] = vertici_ost_om[1]; // y primo vertice
    
    for (int j = 0; j < 12; j = j+2) {
     line(vertici_ost_om[j], vertici_ost_om[j+1], vertici_ost_om[j+2], vertici_ost_om[j+3]);
     // println(vertici_ost_om[20], vertici_ost_om[21], vertici_ost_om[22], vertici_ost_om[23]);
     //println("vertice n.", j, vertici_ost_om[j], vertici_ost_om[j+1], vertici_ost_om[j+2], vertici_ost_om[j+3]);
     }
     //line(vertici_ost_om[10], vertici_ost_om[11], vertici_ost_om[0], vertici_ost_om[1]);
     line(vertici_ost_om[10], vertici_ost_om[11], vertici_ost_om[12], vertici_ost_om[13]);
     
    break;

  case 5: //TRIANGOLO

    h = (l1*sqrt(3))/2;
    //coordinate ostacolo rispetto SR0

    vertici_ost_om[0] = posx + (h/1.5+k_om) * sin(alpha); // Coordinata x del vertice 1
    vertici_ost_om[1] = posy - (h/1.5+k_om) * cos(alpha); // Coordinata y del vertice 1
    vertici_ost_om[2] = posx + (l1/2+k_om) * cos(alpha) - (h/3+k_om) * sin(alpha); // Coordinata x del vertice 2
    vertici_ost_om[3] = posy + (l1/2+k_om) * sin(alpha) + (h/3+k_om) * cos(alpha); // Coordinata y del vertice 2
    vertici_ost_om[4] = posx - (l1/2+k_om) * cos(alpha) - (h/3+k_om) * sin(alpha); // Coordinata x del vertice 3
    vertici_ost_om[5] = posy - (l1/2+k_om) * sin(alpha) + (h/3+k_om) * cos(alpha); // Coordinata y del vertice 3
    /*
    //stampa
     fill(0, 255, 0); //VERDE
     pushMatrix();
     translate(vertici_ost_om[0], vertici_ost_om[1]);
     rotateZ(alpha);
     //rotateZ(PI);
     noStroke();
     sphere(5);
     popMatrix();
     
     fill(#222EF2); ///BLU
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[2], vertici_ost_om[3]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F222F2); //ROSA
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[4], vertici_ost_om[5]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     */
    break;

  case 6: //TRAPEZIO
    h = l2; //altezza

    vertici_ost_om[0] = (-l1/2 - k_om) * cos(alpha) - (-h/2 - k_om) * sin(alpha) + posx; // in basso a sx
    vertici_ost_om[1] = (-l1/2 - k_om) * sin(alpha) + (-h/2 - k_om) * cos(alpha) + posy;

    // vertice 2
    vertici_ost_om[2] = (l1/2 + k_om) * cos(alpha) - (-h/2 - k_om) * sin(alpha) + posx; // in basso a dx
    vertici_ost_om[3] = (l1/2 + k_om) * sin(alpha) + (-h/2 - k_om) * cos(alpha) + posy;

    // vertice 3
    vertici_ost_om[4] = (-l2/2 - k_om) * cos(alpha) - (h/2 + k_om) * sin(alpha) + posx; // in alto a sx
    vertici_ost_om[5] = (-l2/2 - k_om) * sin(alpha) + (h/2 + k_om) * cos(alpha) + posy;

    // vertice 4
    vertici_ost_om[6] = (l2/2 + k_om) * cos(alpha) - (h/2 + k_om) * sin(alpha) + posx; // in alto a dx
    vertici_ost_om[7] = (l2/2 + k_om) * sin(alpha) + (h/2 + k_om) * cos(alpha) + posy;
    /*
    //stampa
     fill(0, 255, 0); //VERDE
     pushMatrix();
     translate(vertici_ost_om[0], vertici_ost_om[1]);
     rotateZ(alpha);
     //rotateZ(PI);
     noStroke();
     sphere(5);
     popMatrix();
     
     fill(#222EF2); ///BLU
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[2], vertici_ost_om[3]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F222F2); //ROSA
     pushMatrix();
     noStroke();
     translate(vertici_ost_om[4], vertici_ost_om[5]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     
     fill(#F4FA56); //GIALLO
     noStroke();
     pushMatrix();
     translate(vertici_ost_om[6], vertici_ost_om[7]);
     rotateZ(alpha);
     sphere(5);
     popMatrix();
     */

    break;
  }

  return vertici_ost_om;
}
