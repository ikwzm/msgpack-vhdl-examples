      SUBROUTINE FIB(N,O)
      INTEGER N,O,I,CURR,NEXT,PREV
      CURR = 0
      NEXT = 1
      I    = 0
 0001 CONTINUE
      IF(I >= N)THEN
        GOTO 0002
      ENDIF
      PREV = CURR
      CURR = NEXT
      NEXT = NEXT + PREV
      I = I + 1
      GOTO 0001
 0002 CONTINUE
      O = CURR
      RETURN
      END
