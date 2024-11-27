//////////////////// PRONTO /////////////////


module sete_segmentos_passo(x, y, z, da, db, dc, dd, de, df, dg);
  input x, y, z;
  output da, db, dc, dd, de, df, dg;
  //x = MSB; z = LSB
  wire nx, ny, nz; //Fios das negações 

  not notx(nx, x); // Negação das entradas
  not noty(ny, y);
  not notz(nz, z);

  // Função do A = x(z'+y) + x'y'z	
  wire ora1, anda1, anda2; // Fios do A

  or or_a1(ora1, nz, y); // Circuito do A
  and and_a1(anda1, x, ora1);
  and and_a2(anda2, nx, ny, z);
  or or_a2(da, anda2, anda1);


  //Funçao do B = x(z+y)	
  wire orb; // Fios do B

  or or_b(orb, z, y); // Circuito do B
  and and_b(db, x, orb);


  //Funçao do C = y(x+z')
  wire orc; //Fios do C

  or or_c(orc, x, nz);  // Circuito do C
  and and_c(dc, y, orc);


  //Funçao do D = x(y+z') + x'y'z
  wire orD, andD, andD1; // Fios do D

  or or_d(orD, y, nz);  // Circuito do D
  and and_d(andD, x, orD);
  and and_d1(andD1, nx, ny, z);
  or or_d1(dd, andD1, andD);


  //Funçao do E = x+z
  or ore(de, x, z); // Circuito do E


  //Funçao do F = x'z + y	
  wire andF; //Fios do F

  and and_f(andF, nx, z); // Circuito do F
  or or_f(df, andF, y);


  //Funçao do G = x'y' + xy
  wire andG, andG1;

  and and_g(andG, nx, ny); // Circuito do G
  and and_g1(andG1, x, y);
  or or_g(dg, andG, andG1);

 
endmodule
