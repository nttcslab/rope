function Cout = rope(Cin, wsize, tau)
	vareps = 0.001;
	para.lambda = .15;	% trade-off coefficient (LIME parameter)
	para.sigma = 2;		% sigma for strategy 3 (LIME parameter)
	para.gamma = 1;		% gamma correction on illumination (LIME parameter)
	para.solver = 1;	% 1: sped-up solver; 2: exact solver (LIME parameter)
	para.strategy = 3;	% identifier of strategy (LIME parameter)

	Ain = max(Cin, [], 3); % value channel in HSV space
	[~, ~, I] = LIME(im2double(Cin), para); % use RTV [15,19] to estimate illumination I
	R = log(max(im2double(Ain), vareps) ./ max(I, vareps)); % reflectance R in logarithmic domain
	Aout = he2d(Ain, R, wsize, tau);
	Cout = im2double(Cin) ./ max(im2double(Ain), vareps) .* Aout;
end

function Aout = he2d(Ain, R, wsize, tau)
	if nargin < 3; wsize = 7; end
	if nargin < 4; tau = 2; end
	vareps = 0.001;

	[Y, X] = size(Ain); off = floor(wsize / 2);

	% Embedding Reflectance in 2D Histogram (Eq. (5))
	pc = zeros(256, 256); % 2D histogram
	for y = (1 + off) : (Y - off)
		for x = (1 + off) : (X - off)
			aq = Ain(y, x);
			rq = R(y, x);
			for dy = - off : off
				for dx = - off : off
					aq_ = Ain(y + dy, x + dx);
					rq_ = R(y + dy, x + dx);
					pc(aq + 1, aq_ + 1) = pc(aq + 1, aq_ + 1) + abs(rq - rq_);
				end
			end
		end
	end
	pc = pc ./ sum(pc(:));

	% Modeling of 1D Histogram as Marginal Probability (Eq. (2))
	s = ones(255, 1); % significance factor
	po = []; % 1D histogram
	for t = 1 : tau % iteration
		po = zeros(255, 1);
		for d = 1 : 255 % difference between intensities
			% 2D histogram values with difference between intensities equal to d
			h = pc(((1 : (256 - d)) - 1) * 256 + (1 : (256 - d)) + d)';
		  if sum(h) == 0; continue; end
		  % fast implementation of Eq. (2) based on convolution
			D = conv(s, ones(d, 1), 'valid'); % denominator of Eq. (3)
			h = h ./ D;
			% fast implementation of Eq. (2) based on convolution
			po = po + conv(h, ones(d, 1)) .* s;
		end
		po = po ./ sum(po);
		s = max(po, vareps);
	end

	% intensity mapping function
	T = cumsum([0; po]);
	Aout = reshape(T(Ain(:) + 1), size(Ain));
end
