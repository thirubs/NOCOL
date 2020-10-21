function [W,H] = goiter(V,W,H,iter,epsilon)
          %up = W.*(V*H'); %without ortho
          up = W.*sqrt(V*H'); % with ortho
          %down = W*(H*H');% without ortho
          dow = W*W';
          doww = V*H';
          down = sqrt(dow*doww); % with ortho
          down(down == 0) = epsilon;
          for k = 1: size(W,1)
                ocd_outlier_score(k,1) = norm(W(k,:));
           end         
           ocd_outlier_score = -zscore(ocd_outlier_score);
            q25 = prctile(ocd_outlier_score,25);
            q75 = prctile(ocd_outlier_score,75);
            iqr = q75-q25;
           o_threshold1 = q75 + (iqr * 1.25);
           o_threshold2 = q25 - (1.25 * iqr);
          ind = 0;
          index_ = (ocd_outlier_score >= o_threshold1) | (ocd_outlier_score <= o_threshold2) ;
		  
          %q50 = prctile(ocd_outlier_score,50); % other threshold selections
          %index_ = (ocd_outlier_score >= q50); %  S1
          %index_ = (ocd_outlier_score <= q50); %  S2
          %index_ = (ocd_outlier_score >= o_threshold1) ; % S3
          %index_ = (ocd_outlier_score <= o_threshold2) ; % S4
          %index_ = (ocd_outlier_score >=min(ocd_outlier_score));
          
          
          %index2_ = ocd_outlier_score < o_threshold;
		  %index_to_update = ocd_outlier_score >= o_threshold;
          index_to_update = index_;
          for j = 1:size(W,1)
                if index_to_update(j) == 1
                    ind = ind + double(V(j,:) > 0.0001);
                end
          end
            ind(ind>0) = 1;
            ind = logical(ind');          
            up2 = H.*(W'*V);
            down2 = (W'*W)*H; % no ortho
            %down = (H*V'*W*H); % with ortho
            down2(down2 == 0) = epsilon;                                     
            W = up./down;
            W=normalize_factor(W,2);
            W(W<=0) = epsilon;
            H(:,ind) = up2(:,ind)./(down2(:,ind));
            H(H<0) = epsilon;
           