/** v2.5 **/

-- 21/08/2018 Para marcaciones
ALTER TABLE rhmarcado DROP mar_in_out;
ALTER TABLE rhmarcado DROP marestado;
UPDATE rhmarcado r SET r.`control` = 0;


