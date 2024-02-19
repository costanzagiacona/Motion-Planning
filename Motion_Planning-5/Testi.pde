PFont myFont; //variabile per poter scegliere il font da mostrare a schermo

void infoi()
{

  if (semsp == true)
  {
    fill(0); //colore nero
    pushMatrix();
    //per ora siamo nel sist riferimento x verso dx e y verso basso
    translate(-width/2, -height/2.2); //valori scelti provando
    textSize(20);
    textAlign(TOP, LEFT); //allinea in alto a sinistra
    stroke(0);
    myFont = createFont("Times New Roman",20, true); //creo il font
    textFont(myFont); //lo uso
    text("ISTRUZIONI", 0, 0);
    text("Scegli lo spazio di lavoro: ", 0, 30);
    text("1) quadrato ", 0, 60);
    text("2) rettangolo ", 0, 90);
    text("3) rombo ", 0, 120);
    text("4) cerchio ", 0, 150);
    text("5) triangolo ", 0, 180);
    text("6) trapezio ", 0, 210);
    text("Premi ENTER per confermare", 0, 250);
    popMatrix();
  }

  if (semost == true)
  {
    fill(0); //colore nero
    pushMatrix();
    //per ora siamo nel sist riferimento x verso dx e y verso basso
    translate(-width/2, -height/2.2); //valori scelti provando
    textSize(20);
    textAlign(TOP, LEFT); //allinea in alto a sinistra
    stroke(0);
    myFont = createFont("Times New Roman", 20, true); //creo il font
    textFont(myFont); //lo uso
    text("ISTRUZIONI", 0, 0);
    text("Scegli la forma degli ostacoli: ", 0, 30);
    text("1) quadrato ", 0, 60);
    text("2) rettangolo ", 0, 90);
    text("3) rombo ", 0, 120);
    text("4) cerchio ", 0, 150);
    text("5) triangolo ", 0, 180);
    text("6) trapezio ", 0, 210);
    if (semins == 0) text("Premi 'o' per aggiungere un nuovo ostacolo", 0, 250);
    if (semins == 1) 
    {
      text("Premi + e - per modificare la dimensione", 0, 250);
      text("Premi RIGHT e LEFT per l'orientamento", 0, 280);
      text ("Premi 'w' per passare alla posizione", 0, 310);
    }
    if (semins == 2) text("Premi UP, DOWN, RIGHT e LEFT per lo spostamento ", 0, 250);


    if (sovrapposizioneost) {
      fill(255, 0, 0);
      textSize(30);
      textAlign(CENTER,CENTER);
      text("Sovrapposizione rilevata", width/2, 0);
    }
    popMatrix();
  }
}
