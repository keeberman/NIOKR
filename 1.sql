select count(*) from (SELECT       vitreaty.treaty_num  treaty_num
                        FROM vitreaty
                       where vitreaty.dateto  >= TO_DATE('01.01.' || (2005 + 1), 'dd.mm.yyyy')
                          AND vitreaty.datefrom < TO_DATE('01.01.' || (2005 + 1), 'dd.mm.yyyy')
                             AND vitreaty.istfin_kod = 2    AND ((TO_DATE('01.06.2005', 'dd.mm.yyyy') IS NULL) OR (vitreaty.datefrom <= TO_DATE('01.06.2005', 'dd.mm.yyyy')))
                             AND ((NULL IS NULL) OR (vitreaty.datefrom >= NULL)))
