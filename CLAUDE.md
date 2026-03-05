# Claude Instructions for hfakhraei.github.io

## Project Overview

This is a personal technical blog (weblog) built with Jekyll 4.2.1 and hosted on GitHub Pages. The site belongs to Hossein Fakhraei, a Senior Java Developer with expertise in Spring Boot, microservices, AWS, and enterprise applications.

**Site URL**: https://hfakhraei.github.io/

## Project Structure

```
.
├── _config.yml           # Jekyll configuration
├── _posts/               # Blog posts (YYYY-MM-DD-title.md format)
├── _layouts/             # HTML layouts (default, post, page, tag)
├── _includes/            # Reusable HTML components
├── _sass/                # SCSS stylesheets
├── assets/               # Static assets (images, CSS, JS)
│   ├── css/
│   ├── js/
│   └── images/
│       └── posts/        # Post images organized by year
├── about.md              # About page
├── Gemfile               # Ruby dependencies
└── README.md
```

## Technology Stack

- **Static Site Generator**: Jekyll 3.8.5
- **Hosting**: GitHub Pages
- **Markup**: Markdown (kramdown)
- **Templating**: Liquid
- **Styling**: SCSS/Sass (compressed output)
- **Jekyll Plugins**:
  - jekyll-paginate (5 posts per page)
  - jekyll-tagsgenerator
  - jekyll-seo-tag
  - jekyll-sitemap
  - jekyll-coffeescript

## Content Guidelines

### Blog Posts

Posts are stored in `_posts/` with filename format: `YYYY-MM-DD-title.md`

**Front Matter Template**:
```yaml
---
layout: post
title: "Your Post Title"
tags: [ Tag1, Tag2, Tag3 ]
featured_image_thumbnail: /assets/images/posts/YYYY/YYYY-MM-DD/thumbnail.jpg
featured_image: /assets/images/posts/YYYY/YYYY-MM-DD/featured.jpg
featured: true    # Optional: mark as featured
hidden: true      # Optional: hide from listing but keep accessible
---
```

**Common Post Topics**:
- Java programming and best practices
- Spring Boot and Spring Framework
- LeetCode problem solutions with Java
- Kubernetes and Docker
- AWS services and deployment
- Linux/Ubuntu tutorials
- Git and GitHub workflows
- Enterprise application development

### Code Blocks

Use pre/code tags with language classes for syntax highlighting:

```html
<pre><code class="language-java">
public class Example {
    // Java code here
}
</code></pre>
```

**HTML Entity Encoding Required**:
- `<` → `&lt;`
- `>` → `&gt;`
- `&` → `&amp;`

Supported languages: java, markup (for XML/HTML), bash, sql, javascript, css

### YouTube Video Embeds

Use the custom YouTube include:
```html
<div class="youtube" id="VIDEO_ID_HERE"></div>
```

### Images

- Store images in `/assets/images/posts/YYYY/YYYY-MM-DD/`
- Use descriptive filenames
- Provide both thumbnail and featured image versions
- Reference images with absolute paths starting with `/assets/`

## Development Workflow

### Local Development

#### Option 1: Native Ruby/Jekyll (Recommended for Mac)

```bash
# Quick start with helper script
./run-native.sh

# Or manually:
# Install dependencies (first time only)
bundle install --path .jekyll/gems

# Run Jekyll server with live reload
bundle exec jekyll serve --livereload

# Build site
bundle exec jekyll build

# Clean generated files and caches
./clean.sh
```

The site will be available at http://localhost:4000

#### Option 2: Container (Docker Desktop)

```bash
# Quick start with helper script (cross-platform)
./run.sh

# Script automatically:
# - Uses Docker Desktop (or Podman if available)
# - Warns on Apple Silicon about potential issues
# - Uses Jekyll 3.8 matching Gemfile
# - Caches gems in Docker volume (jekyll-gems-3.8) for faster subsequent runs
# - First run: ~2-3 minutes (installs gems)
# - Subsequent runs: ~10 seconds (uses cached gems)
```

**Important Container Limitations:**
- **No live reload** - Must manually refresh browser after changes
- **Slower on Apple Silicon** - Runs AMD64 with emulation
- **SCSS issues possible** - BrokenPipe errors may occur on Apple Silicon

**🎯 For the best development experience on Mac, use native Ruby (`./run-native.sh`)**

#### Prerequisites

**For Native Development:**
- Ruby 2.7+ installed
- Bundler gem: `gem install bundler`
- All dependencies will be installed to `.jekyll/gems` directory

**For Container Development:**
- **Docker Desktop** (recommended): `brew install --cask docker` or download from https://www.docker.com/products/docker-desktop
- Alternatives: Podman, OrbStack (see SETUP_MAC.md for details)
- No Ruby installation needed
- **Note:** Containers on Apple Silicon may have SCSS compilation issues. Native Ruby is strongly recommended.

### Creating New Posts

1. Create file in `_posts/` with correct naming: `YYYY-MM-DD-title.md`
2. Add required front matter
3. Write content in Markdown
4. Add images to `/assets/images/posts/YYYY/YYYY-MM-DD/`
5. Test locally before committing
6. Commit and push to master branch (auto-deploys to GitHub Pages)

### Git Workflow

- **Main branch**: `master`
- Commits to master automatically trigger GitHub Pages rebuild
- Gemfile.lock is deleted (already in .gitignore or being removed)

## Site Configuration (_config.yml)

Key settings:
- **Author**: Hossein Fakhraei
- **Description**: Java Developer
- **Email**: HFakhraei@outlook.com
- **Pagination**: 5 posts per page
- **Permalink**: `/:title` (clean URLs without dates)
- **Markdown**: kramdown
- **Sass style**: compressed

### Social Links

Configured social media handles:
- GitHub: hfakhraei
- Twitter: hfakhraei
- LinkedIn: hfakhraei
- Facebook: hfakhraei
- Instagram: hfakhraei

## Writing Style and Conventions

- **Tone**: Technical, educational, straightforward
- **Audience**: Software developers and engineers
- **Code focus**: Java, Spring Boot, enterprise patterns
- Posts often include:
  - Problem descriptions
  - Step-by-step solutions
  - Code examples with explanation
  - Links to GitHub repositories
  - YouTube video explanations

## Common Tasks

### Update About Page

Edit `about.md` with work experience, skills, and education. Keep the professional format with clear sections.

### Add New LeetCode Solution

1. Create post: `_posts/YYYY-MM-DD-Leetcode-XXX.md`
2. Use tags: `[ Leetcode ]`
3. Include:
   - Problem description with examples
   - Constraints
   - Java solution in code block
   - YouTube video embed if available
4. Add screenshot: `/assets/images/posts/YYYY/YYYY-MM-DD/LeetCode-XXX.jpg`

### Add Technical Tutorial

1. Choose descriptive title and date
2. Use relevant tags (e.g., Spring-Boot, Docker, Kubernetes)
3. Include code examples with proper syntax highlighting
4. Add explanatory text between code blocks
5. Link to GitHub repo if applicable
6. Add relevant featured images

## Important Notes

- **No emoji usage** unless explicitly requested
- **Build before committing** to catch Jekyll errors
- **Test images paths** to ensure they load correctly
- **Validate YAML front matter** to prevent build failures
- **Use proper HTML entities** in code blocks
- **Maintain consistent post naming** convention
- **Keep _config.yml synchronized** with actual social profiles
- **Respect pagination settings** (currently 5 posts per page)

## SEO and Analytics

- Jekyll SEO tag plugin handles meta tags automatically
- Google Analytics ID can be configured in `_config.yml` (currently empty)
- Sitemap and feed.xml are auto-generated
- Social media metadata is pulled from front matter

## Troubleshooting

### Build Failures
- Check YAML front matter syntax
- Verify image paths are correct
- Ensure Gemfile dependencies are installed
- Look for unclosed HTML tags in posts

### Missing Images
- Confirm path starts with `/assets/`
- Check file exists in correct year/date folder
- Verify image filename matches front matter

### Layout Issues
- Clear Jekyll cache: `bundle exec jekyll clean`
- Rebuild: `bundle exec jekyll build`
- Check _layouts and _includes for template errors

## Maintenance

- Keep Jekyll and plugins updated via Gemfile
- Regularly review and update About page with new experience
- Archive or organize old posts by categories/tags as needed
- Monitor GitHub Pages build status after pushing changes
- Keep asset folder organized by year and date
