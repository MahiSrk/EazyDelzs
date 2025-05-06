package com.eazydelzs.servlet;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

/**
 * This listener shuts down the MySQL AbandonedConnectionCleanupThread when the application stops,
 * to avoid memory leaks on Tomcat 10+.
 */
@WebListener
public class CleanupListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        AbandonedConnectionCleanupThread.checkedShutdown();
		System.out.println("✅ AbandonedConnectionCleanupThread shutdown successfully.");
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // No specific initialization needed here
        System.out.println("🟢 CleanupListener initialized.");
    }
}


