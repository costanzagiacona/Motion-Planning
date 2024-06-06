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

  // modifica velocità scanner
  if (key == 'A') //scannero velocità massima
  {
    num_iter = 300;
  }
  if (key == 'a') //scanner velocità minima
  {
    num_iter = 500;
  }

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
    if (key == '+') //aumento dimensione spazio lavoro
    {
      incrsp += kp;
      if (incrsp > 100) incrsp=100;
    }

    if (key == '-') //diminuisco dimensione spazio lavoro
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
        //inizializzo variabili
        x = 0; //posizione ostacolo
        y = 0;
        orientamento = 0;
        incrost = 0;
        nfiguraost = 1;
        lato1 = 50; //dimensioni di default
        lato2 = 70;
        // dimensioni ombra
        if (nfiguraost == 4) k = 1.5*25; //cerchio
        else k = 50;
        semins = 1; //passo alla parte successiva
      }
    }

    //SEMINS 1
    if (semins == 1)
    {
      //rilevo sovrapposizione con altri ostacoli o tavolo
      if (nfiguraost == 4) {
        sovrapposizioneost = sovrapposizione(x, y, (lato1/3)+(incrost/2), (lato1/3)+(incrost/2), orientamento, 1.5*k);
      }//funzione in 'Collisioni ostacoli'
      else {
        sovrapposizioneost = sovrapposizione(x, y, lato1+incrost, lato2+incrost, orientamento, k);
      } //funzione in 'Collisioni ostacoli'

      if (key == '+') //aumento dimensione ostacolo
      {
        incrost += kp;
        if (incrost > 100) incrost = 100;
      }

      if (key == '-') //diminuisco dimensione ostacolo
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
    if (semins == 2) //modifica posizione ostacolo
    {
      //modifica OMBRA
      if (key == '+') //aumento dimensione ombra ostacolo
      {
        k += kp;
        if(k > 60) k = 60;
      }

      if (key == '-') //diminuisco dimensione ombra ostacolo
      {
        k -= kp;
        if (k < r_r/2) k = r_r/2; //non può essere più piccolo di metà del robot
      }

      //modifica POSIZIONE
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

      //sovrapposizioneost = sovrapposizione(x, y, lato1+incrost, lato2+incrost, orientamento);
      if (nfiguraost == 4) {
        sovrapposizioneost = sovrapposizione(x, y, (lato1/3)+(incrost/2), (lato1/3)+(incrost/2), orientamento, 1.5*k);
      } else {
        sovrapposizioneost = sovrapposizione(x, y, lato1+incrost, lato2+incrost, orientamento, k);
      } //funzione in 'Collisioni ostacoli'

      if (keyCode == TAB)
      {
        if (!sovrapposizioneost) //se non ci sono sovrapposizioni posso istanziare l'ostacolo
        {
          numero_ostacoli++;
          id_ost++;
          //if (numero_ostacoli >= MAX_OST) semost = false; //raggiunto numero max ostacoli
          if (nfiguraost == 4) Ostacolo_creazione(id_ost, x, y, (lato1/3)+(incrost/2), (lato1/3)+(incrost/2), orientamento, nfiguraost, false, 1.5*k); //cerchio
          else {
            Ostacolo_creazione(id_ost, x, y, lato1+incrost, lato2+incrost, orientamento, nfiguraost, false, k);
          }
          semins = 0;  //ricominciamo e creiamo un nuovo ostacolo se vogliamo
        }
      }
    }
  }
}
