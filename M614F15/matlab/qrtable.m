function qrtable()
% QRTABLE  Solves P16(c) on Assignment #7:  Table showing accuracy measures
% for various QR algorithms on a random matrix.

A = randn(50,12);

fprintf('   method  unitaryness  triangularity  factorization\n')
fprintf(' ========  -----------------------------------------\n')
[Q,R] = clgs(A);
measures('clgs',A,Q,R);
[Q,R] = mgs(A);
measures('mgs',A,Q,R);
[W,R] = house(A);
Q = formQ(W);
measures('house',A,Q,R);
[Q,R] = qr(A,0);
measures('built-in',A,Q,R);

  function measures(name,A,Q,R)
    n = size(R,1);
    fprintf('%9s     %6.2e       %6.2e       %6.2e\n', ...
            name,norm(Q'*Q - eye(n)), norm(tril(R,-1)), norm(Q*R-A)/norm(A));
  end
end % qrtable()
