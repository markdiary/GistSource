package GistSource::Tags;
use strict;
use warnings;

sub _hdlr_gist_source{
	my ($str, $arg, $ctx) = @_;
	return $str if $arg != 1;
	my $plugin = MT->component('GistSource');
	my $blog_id = $ctx->stash('blog_id');
	my $do_gistsource = $plugin->get_config_value('doGistSource', 'blog:'.$blog_id);
	return $str unless ($do_gistsource eq 1);

	my $add_type_attr = $plugin->get_config_value('addTypeAttribute', 'blog:'.$blog_id);
	$str =~ s/(?:\[)gist:(?:\s+)?([0-9]{1,9})(?:\])/&_gist($1, $add_type_attr)/eg;

	return $str;
}

sub _gist{
	my ($gistid, $add_type_attr) =@_;
	my $line;
	my $type = $add_type_attr eq 1 ? qq( type="text/javascript") : '';

$line = <<"HEREDOC";
\n<script src="https://gist.github.com/$gistid.js"$type></script>\n
HEREDOC
}

1;