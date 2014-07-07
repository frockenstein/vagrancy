<?php
/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'Mzb.G9bp(>LGrEL=R81z({InTX4.X:oGDc.57xe11jVFeB]5Bn');
define('SECURE_AUTH_KEY',  'hTHWR30BVv(b7mw,\\f8XYw<uOiB@C=08k/B4Z+hP`<9ajz4+IM');
define('LOGGED_IN_KEY',    ')Ngj7uh6,-Qp<QJFIcJ2=F,RcOMG5<E-a,-@AMWzD77>Sfqa4r');
define('NONCE_KEY',        'Qtjm./:}OZC;Hu-vR2/=0]1RC6N_p]T|=pI_.e9@A[[-}Up6zo');
define('AUTH_SALT',        '?4+/5*P9FOPV15:>biQ4HQ?r_u)N1jZbxxX{d9iK\\ssJV4CZqL');
define('SECURE_AUTH_SALT', '4@`-Wp4a>1>d^Dd=g/{CAgLIt_93G_gVq*CtybBbKlN@ha-fmL');
define('LOGGED_IN_SALT',   'qTjbIbbR9*Q=N\\kk3;n82bBwnA(_qEz\\zbADp0]GvMMWBZ?lst');
define('NONCE_SALT',       '+y}eKnrXv5>(-f(<Ap3^4NaTIUOTMGp[aIUKlwqf|*k<iO3<T6');

/**#@-*/

/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', 'password');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */

define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', true);
define('WP_ALLOW_MULTISITE', true);


/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
        define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
