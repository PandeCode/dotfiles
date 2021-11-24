{
	rate=1024;

	b = $1;
	k = b/rate;
	m = k/rate;
	g = m/rate;
	t = g/rate;
}

END {
	if(b < rate)
		printf("%fB", b)
	else if(k < rate)
		printf("%fB | %fKB", b, k)
	else if(m < rate)
		printf("<b>%fB | %fKB | %fMB</b>", b, k, m)
	else if(g < rate)
		printf("%fB | %fKB | %fMB | %fGB", b, k, m, g)
	else
		printf("%fB | %fKB | %fMB | %fGB | %fTB ", b, k, m, g, t)
}
