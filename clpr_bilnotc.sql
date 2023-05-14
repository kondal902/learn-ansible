create or replace PROCEDURE clpr_bilnotc
		(
		
		P_DLY_MSG_OUT_ROW IN OUT NOCOPY MSTB_DLY_MSG_OUT%ROWTYPE,
		P_TB_PARAM_LIST IN OUT NOCOPY MSPKS_ADV_GEN.TB_PARAM_LIST
		)
AS
L_REC_BNTC   CLPKSS_TIMEBASED_ADVICES.TY_REC_TBAD;
L_ERROR_CODE   VARCHAR2(200);
BEGIN
	CLPKS_ADVICES.PR_ADD_PARAMETER(P_TB_PARAM_LIST,'branch_code',P_DLY_MSG_OUT_ROW.BRANCH);
	CLPKS_ADVICES.PR_ADD_PARAMETER(P_TB_PARAM_LIST,'account_number',P_DLY_MSG_OUT_ROW.REFERENCE_NO);
	
  	
	
  
   
    DEBUG.PR_DEBUG('CL','Calling c3pk#_prd_shell.fn_get_billnotc_adv...');
    IF NOT C3PK#_PRD_SHELL.FN_GET_BILLNOTC_ADV(P_DLY_MSG_OUT_ROW.PRODUCT,
                                               P_DLY_MSG_OUT_ROW.REFERENCE_NO,
                                               L_REC_BNTC,
                                               P_DLY_MSG_OUT_ROW.BRANCH,
                                               L_ERROR_CODE)
    THEN
        DEBUG.PR_DEBUG('CL','c3pk#_prd_shell.fn_get_billnotc_adv failed with :-( ' || L_ERROR_CODE);
        L_REC_BNTC.NUM_DAYS:= 0;
    END IF;
    DEBUG.PR_DEBUG('CL','In clpr_bilnotc l_rec_bntc.num_days->'||L_REC_BNTC.NUM_DAYS);
    CLPKS_ADVICES.PR_ADD_PARAMETER(P_TB_PARAM_LIST,'num_days',L_REC_BNTC.NUM_DAYS);	
	
END CLPR_BILNOTC;
/
