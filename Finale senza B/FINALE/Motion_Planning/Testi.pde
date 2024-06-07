PFont myFont; //variabile per poter scegliere il font da mostrare a schermo

void infoi()
{
  pushMatrix();
  //per ora siamo nel sist riferimento x verso dx e y verso basso
  translate(-width/2, -height/2.2); //valori scelti provando
  myFont = createFont("Times New Roman", 20, true); //creo il font
  textFont(myFont); //lo uso
  textSize(20);
  fill(0);
  stroke(0);
  textAlign(TOP, LEFT);
  /*
  text("Sistema di riferimento: ", 1100, 0);
  fill(#2AB459);
  text("x, ", 1295, 0);
  fill(#F04030);
  text("y, ", 1315, 0);
  fill(#FAF24C);
  text("z ", 1335, 0);
  */
  fill(0);
  text ("Il target è verde", 1100, 0);
  
  textAlign(BOTTOM, LEFT);
  fill(0);
  text("Premi 'g' per ruotare il tavolo verso l'alto", 0, 700);
  text("Premi 'G' per ruotare il tavolo verso il basso", 0, 730);
  text("Premi 'h' per ruotare il tavolo verso sinistra", 0, 760);
  text("Premi 'H' per ruotare il tavolo verso destra", 0, 790);

  if (semsp == true)
  {
    fill(0); //colore nero
    textSize(20);
    textAlign(TOP, LEFT); //allinea in alto a sinistra
    stroke(0);
    text("ISTRUZIONI", 0, 0);
    text("Scegli lo spazio di lavoro: ", 0, 30);
    text("1) quadrato ", 0, 60);
    text("2) rettangolo ", 0, 90);
    text("3) rombo ", 0, 120);
    text("4) cerchio ", 0, 150);
    text("5) triangolo ", 0, 180);
    text("6) trapezio ", 0, 210);
    text("Premi ENTER per confermare", 0, 250);
  }

  if (semost == true)
  {
    fill(0); //colore nero

    textSize(20);
    textAlign(TOP, LEFT); //allinea in alto a sinistra
    stroke(0);
    text("ISTRUZIONI", 0, 0);
    text("Scegli la forma degli ostacoli: ", 0, 30);
    text("1) quadrato ", 0, 60);
    text("2) rettangolo ", 0, 90);
    text("3) rombo ", 0, 120);
    text("4) cerchio ", 0, 150);
    text("5) triangolo ", 0, 180);
    text("6) trapezio ", 0, 210);
    if (semins == 0)
    {
      text("Premi 'o' per aggiungere un nuovo ostacolo", 0, 250);
      text("Premi ENTER per iniziare la scannerizzazione", 0, 280);
    }
    if (semins == 1)
    {
      text("Premi + e - per modificare la dimensione", 0, 250);
      text("Premi RIGHT e LEFT per l'orientamento", 0, 280);
      text ("Premi 'w' per passare alla posizione", 0, 310);
    }

    if (semins == 2)
    {
      text("Premi UP, DOWN, RIGHT e LEFT per lo spostamento ", 0, 250);
      text("Premi + e - per modificare la dimensione dell'ombra", 0, 280);
      text("Premi TAB per confermare", 0, 310);
    }


    if (sovrapposizioneost) 
    {
      fill(255, 0, 0);
      textSize(30);
      textAlign(CENTER, CENTER);
      text("Sovrapposizione rilevata", width/2, 0);
    }
  }
  
  if (semsp == false && semost == false && arrived == false)
  {
    textSize(30);
    fill(0);
    text("Scanning...",0,0);
    textSize(20);
    text("Premi 'A' per aumentare la velocità di scan",0,50);
    text("Premi 'a' per diminuire la velocità di scan",0,80);
  }
  if (arrived == true)
  {
    textSize(30);
    textAlign(CENTER, CENTER);
    fill(#277111);
    text("TARGET TROVATO! ",width/2,0);
  }
  popMatrix();
}
