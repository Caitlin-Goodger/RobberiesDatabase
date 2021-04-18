SELECT s.Description, h.RobberId, r.Nickname FROM hasskills h, skills s, robbers r WHERE h.skillid = s.skillid AND h.robberid = r.RobberId ORDER BY s.description
