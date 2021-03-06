function [x1,x2,errflag] = quadroot(a,b,c)
%
% Author: Matthew Petty
%
% This program has been modified after grading
% comments by Dr. Mark Arnold, University of Arkansas.
% Changes are denoted by inline comments.
%
% This function approximates the roots of a
% quadratic equation, whose coefficients are
% given by the "user" (likely another subroutine).
%
% Input variables are real-valued coefficients
% a, b, c such that ax^2 + bx + c = 0.
%
%
% It returns variables x1 and x2, whose values are
% explained by the following error flags:
% -1 - The inputs were nonsensical/contradictory
%  0 - Distinct real roots
%  1 - Non-distinct real roots, may be inaccurate
%      due to cancellation error
%  2 - Complex roots, x1 is real, x2 is imaginary
%  3 - The relative magnitude of a to other
%      coefficients is so small a quadratic
%      solution would be inaccurate, x2 is ignored
%  4 - A catastrophic programming error occured.

% First, the returned variables are initialized.

x1 = 0;
x2 = 0;
errflag = 0;

% Second, the inputs are scaled so that the largest
% coefficient is between 1/2 and 2.

m = max(abs([a,b,c]));
if m <= eps			%
errflag = -1;
return;
elseif b < 0			% though this line is not strictly
m = -m;				% necessary, it simplifies the
end  				% check for cancellation errors
					% in the case of distinct, real roots
a = a/m;
b = b/m;
c = c/m;

% Now the inputs are tested for specific cases where
% applying a quadratic-solving algorithm to find the
% roots would be silly.

if abs(a) <= eps
  if abs(b) <= eps		% if the inputs are nonsensical
  errflag = -1;
  return;
  end  
x1 = -c / b;			% solving a quadratic of order 1
errflag = 3;
return;
end

% If we've made it this far, we are dealing with a quadratic

d = b*b - 4*a*c;		% this produces cancellation error, but
					% what can be done?

if d < 0				% complex conjugate roots
  x1 = -b / ( 2 * a);  
  x2 = sqrt(-d);		% the assignment is to use real arithmetic
  errflag = 2;
  return;
elseif abs(d) <= eps	% non distinct real roots
  errflag = 1;			
  x1 = -b / (2 * a);
  x2 = x1;
  return;
     
else					% distinct, real roots

% Note b > 0 from earlier. To avoid cancellation we first compute
% x1 = (-b - sqrt(d))/2a and then compute x2 after algebraic
% manipulation of the quadratic formula.

  q = -b - sqrt(d); 	% just to save calculating it an extra time
  x1 = q/(2*a);
  x2 = c/(a*x1);		% modified due to grading comments
  errflag = 0;
  return;
end

errflag = 4;			% You should never see this.

