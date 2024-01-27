
void mouseDragged() {
  angoloY = angoloYpartenza - PI*mouseX/float(10); //DA MODIFICARE <===  !!!!!!
  angoloX = angoloXpartenza - PI*mouseY/float(10);
}

void keyPressed() 
{
  if (keyCode == '1') nfigura = 1; //quadrato
  if (keyCode == '2') nfigura = 2; //rettangolo
  if (keyCode == '3') nfigura = 3; //rombo
  if (keyCode == '4') nfigura = 4; //cerchio
  if (keyCode == '5') nfigura = 5; //triangolo
  if (keyCode == '6') nfigura = 6; ///trapezio
  
  if(keyCode == 'X') eyeX += 25;
  if(keyCode == 'x') eyeX -= 25;
  if(keyCode == 'Y') eyeY += 25;
  if(keyCode == 'y') eyeY -= 25;
  
  if (keyCode == RIGHT) 
  {
    incr += kp;
    if(incr > 300) incr=300;
  }
  
  if (keyCode == LEFT) 
  {
    incr -= kp;
    if(incr < kp) incr = kp;

  }
  
  /*
  if (keyCode == ENTER) 
  {
    qr1 = PI/2;
    qr2 = PI/2;
    qr3 = 2;
  }
  */
}
