SELECT bankname, city, noaccounts FROM banks b WHERE bankname NOT IN (SELECT d.bankname FROM Banks d WHERE d.city = 'Deerfield') ORDER BY noaccounts



