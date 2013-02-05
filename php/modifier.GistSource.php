<?php 
function smarty_modifier_GistSource( $str, $args) {
	if ($args != 1) {
		return $str;
	}
	$str = preg_replace_callback('/(?:\[)gist:(?:\s.+)?([0-9]{1,9})(?:\])/', "gist" , $str, 5);
	return $str;
}
function gist($matches){
    $mt = empty($mt)? (MT::get_instance()) : $mt;
    $ctx =& $mt->context();
    $blog_id = 'blog:' . $ctx->stash('blog_id');
    $conf = $mt->db()->fetch_plugin_data ( 'GistSource', 'configuration:' . $blog_id );
    $doGistSource = $conf['doGistSource'];
    if ( $doGsitSource == 0 ){ return $matches[0]; }
    $add_type_attr = $conf['addTypeAttribute'];
    $type  = $add_type_attr =='1' ? ' type="text/javascript"' : '';
    $line = '<script src="https://gist.github.com/' .$matches[1]. '.js"' .$type. '></script>';
    return $line;
}
?>