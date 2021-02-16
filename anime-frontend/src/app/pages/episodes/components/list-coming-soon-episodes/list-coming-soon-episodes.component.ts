import { Component, OnInit } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { EpisodesService } from '../../services/episodes.service';
import { EpisodeComingSoonResponse } from '../../entity/episode-coming-soon-response';
import { EpisodeComingSoon } from '../../entity/episode-coming-soone';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-list-coming-soon-episodes',
  templateUrl: './list-coming-soon-episodes.component.html',
  styleUrls: ['./list-coming-soon-episodes.component.scss']
})
export class ListComingSoonEpisodesComponent implements OnInit {
  episodesComingSoon: EpisodeComingSoon[];
  episodesComingSoonList: EpisodeComingSoon[] = [];
  episodesComingSoonFilterList: EpisodeComingSoon[] = [];         // We Create It Second For Filter
  config: any;                                      // Config Variable For Pagination Configuration
  name: string;
  isClicked = false;
  episodsComingSoonSubscription: Subscription;

  constructor(private episodesService: EpisodesService,
              private toaster: ToastrService,
              private router: Router,
              private activateRoute: ActivatedRoute) { }

  ngOnInit() {

    // Get All Animes
    this.getAllEpisodesComingSoon();
  }

  ngOnDestroy() {
    this.episodsComingSoonSubscription.unsubscribe();
  }

  // Get All Animes
  getAllEpisodesComingSoon() {
    this.episodsComingSoonSubscription = this.episodesService.allEpisodesComingSoon().subscribe(
      (episodesComingSoon: EpisodeComingSoonResponse) => {
        if (episodesComingSoon) {
          // console.log('all episodesComingSoon :', episodesComingSoon);
          this.episodesComingSoon = episodesComingSoon.Data;
          this.episodesComingSoonList = episodesComingSoon.Data;
        }
      },
      error => this.handleError(error),
      () => this.episodesComingSoonFilterList = this.episodesComingSoonList
    );

    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.episodesComingSoonList.length
    };
  }

  // Handle Response Error
  handleError(error) {
    this.isClicked = false;
    this.episodesComingSoon = [];
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
    setTimeout(() => {
      this.router.navigate(['../../'], {relativeTo: this.activateRoute})
    }, 2000);
  }


  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  // Delete The Category
  delete(episodeID: number) {
    if (confirm('Are You Sure You Want To Delete This Episode')) {
      this.episodesService.deleteEpisode(episodeID).subscribe(
        data => {
          this.toaster.success('Episode Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
        this.getAllEpisodesComingSoon();
        }
      );
    } else {
      return false;
    }
  }


  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.episodesComingSoonFilterList = [...this.episodesComingSoonList];
    } else {
      this.episodesComingSoonFilterList = [];
      this.episodesComingSoonFilterList = this.episodesComingSoonList.filter(res => {
        if (res.animeName) {
          // Search In Name Column
          const nameResult = res.animeName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (nameResult) {
            // display the Name Column
            return nameResult;
          }
        }
        if (res.episodeNumber) {
          // Search In Episode Number Column
          const episodeNumber = res.episodeNumber.toString().match(this.name.toLocaleLowerCase());
          if (episodeNumber) {
            // display the episodeNumber Column
            return episodeNumber;
          }
        }
      });
    }
  }


}
