
void mouseDragged() {
  angoloY = angoloYpartenza - PI*mouseX/float(1000); //DA MODIFICARE <===  !!!!!!
  angoloX = angoloXpartenza - PI*mouseY/float(1000);
}

void keyPressed()
{
  if (semsp) //CAMBIO FIGURA SPAZIO DI LAVORO
  {
    if (keyCode == '1') nfigurasp = 1; //quadrato
    if (keyCode == '2') nfigurasp = 2; //rettangolo
    if (keyCode == '3') nfigurasp = 3; //rombo
    if (keyCode == '4') nfigurasp = 4; //cerchio
    if (keyCode == '5') nfigurasp = 5; //triangolo
    if (keyCode == '6') nfigurasp = 6; ///trapezio
  }

  if (semost) //CAMBIO FIGURA OSTACOLI
  {
    if (keyCode == '1') nfiguraost = 1; //quadrato
    if (keyCode == '2') nfiguraost = 2; //rettangolo
    if (keyCode == '3') nfiguraost = 3; //rombo
    if (keyCode == '4') nfiguraost = 4; //cerchio
    if (keyCode == '5') nfiguraost = 5; //triangolo
    if (keyCode == '6') nfiguraost = 6; ///trapezio
  }
  //VISTA
  if (keyCode == 'X') eyeX += 25;
  if (keyCode == 'x') eyeX -= 25;
  if (keyCode == 'Y') eyeY += 25;
  if (keyCode == 'y') eyeY -= 25;


  if (keyCode == ENTER)
  {
    if (semsp == true) //finito di creare lo spazio di lavoro passiamo alla creazione degli ostacoli
    {
      semsp = false;
      semost= true;
      x = 0;
      y = 0;
      orientamento = 0;
      incrost = 0 ;
    } else if (semsp == false) //finita la creazione degli ostacoli passiamo al grafo
    {
      semsp = false;
      semost= false;
    }
  }

  /*MODIFICA SPAZIO DI LAVORO*/
  if (semsp == true)
  {
    if (key == '+') //aumento dimensione spazio lavoro o ostacolo
    {
      incrsp += kp;
      if (incrsp > 100) incrsp=100;
    }

    if (key == '-') //diminuisco dimensione spazio lavoro o ostacolo
    {
      incrsp -= kp;
      if (incrsp < kp) incrsp = kp;
    }
  }

  /*MODIFICA OSTACOLI*/
  else if (semost == true)
  {
    //SEMINS 0
    if (semins == 0)
    {
      if (key == 'o')
      {
        x = 0;
        y = 0;
        orientamento = 0;
        incrost = 0;
        nfiguraost = 1;
        lato1 = 50;
        lato2 = 70;
        semins = 1;
      }
    }

    //SEMINS 1
    if (semins == 1)
    {
      sovrapposizioneost = sovrapposizione(x, y, lato1+incrost, lato2+incrost, orientamento);

      if (key == '+') //aumento dimensione spazio lavoro o ostacolo
      {
        incrost += kp;
        if (incrost > 100) incrost = 100;
      }

      if (key == '-') //diminuisco dimensione spazio lavoro o ostacolo
      {
        incrost -= kp;
        if (incrost < kp) incrost = kp;
      }

      //orientamento ostacoli
      if (keyCode == RIGHT)
      {
        orientamento = orientamento + PI/24;
      }

      if (keyCode == LEFT)
      {
        orientamento = orientamento - PI/24;
      }

      if (key == 'w') semins = 2;
    }


    //SEMINS 2
    if (semins == 2)
    {

      if (keyCode == DOWN)
      {
        //posizione ostacolo
        y += 20; //posizione ostacolo
      }

      if (keyCode == UP)
      {
        //posizione ostacolo
        y -= 20; //posizione ostacolo
      }

      //orientamento ostacoli
      if (keyCode == RIGHT)
      {
        x += 20; //posizione ostacolo
      }

      if (keyCode == LEFT)
      {
        x -= 20; //posizione ostacolo
      }

      sovrapposizioneost = sovrapposizione(x, y, lato1+incrost, lato2+incrost, orientamento);

      if (keyCode == TAB)
      {
        if (!sovrapposizioneost) //ricominciamo e creiamo un nuovo ostacolo
        {
          numero_ostacoli++;
          if (numero_ostacoli >= MAX_OST) semost = false; //raggiunto numero max ostacoli
          Ostacolo_creazione(numero_ostacoli, x, y, lato1+incrost, lato2+incrost, orientamento, nfiguraost);
          semins = 0;
        }
      }
    }
  }

  // visual home lungo Y
  if (key == 'h') {
    angoloY += 0.05;
  }
  if (key == 'H') {
    angoloY -= 0.05;
  }
  // visual home lungo X
  if (key == 'g') {
    angoloX += 0.05;
  }
  if (key == 'G') {
    angoloX -= 0.05;
  }
}
