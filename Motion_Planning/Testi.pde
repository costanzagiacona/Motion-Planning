PFont myFont; //variabile per poter scegliere il font da mostrare a schermo

void infoi()
{
  fill(0); //colore nero
  pushMatrix();
  //per ora siamo nel sist riferimento x verso dx e y verso basso
  translate(-width/2, -height/2.2); //valori scelti provando
  textSize(20);
  textAlign(TOP,LEFT); //allinea in alto a sinistra
  stroke(0);
 // myFont = createFont("Times New Roman",20, true); //creo il font
  //textFont(myFont); //lo uso
  text("Istruzioni", 0,0);
  text("Scegli la tua figura: ",0,30);
  text("1) quadrato ",0,60);
  text("2) rettangolo ",0,90);
  text("3) rombo ",0,120);
  text("4) cerchio ",0,150);
  text("5) triangolo ",0,180);
  text("6) trapezio ",0,210);
  
  
  popMatrix();
}
